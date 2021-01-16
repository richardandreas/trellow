# frozen_string_literal: true

module Api
  # ApiController
  class ApiController < ActionController::Base
    attr_reader :current_user

    skip_before_action :verify_authenticity_token # TODO: Remove this before online deployment

    before_action :authenticate

    private

    def authenticate
      @session      = JwtService.decode(request.headers['access-token'])
      @current_user = User.find_by_id(@session[:user_id]) if @session && @session[:expiration] > Time.now

      return head :unauthorized if @current_user.nil?

      # Avoids ending an active users session if he/she makes a request 10 minutes before session expiry.
      # The client is responsible for storing every new token.
      create_access_token(@current_user.id) if @session[:expiration] > 10.minutes.from_now
    end

    def create_access_token(user_id)
      response.headers['access-token'] = JwtService.encode({ user_id: user_id, expiration: 30.minutes.from_now })
    end
  end
end
