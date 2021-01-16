# frozen_string_literal: true

module Api
  # ApiController
  class ApiController < ActionController::Base
    SESSION_TIMEOUT  = 30.minutes
    SESSION_DEADLINE = 8.hours
    REMEMBER_TIMEOUT = 3.months

    attr_reader :current_user

    skip_before_action :verify_authenticity_token # TODO: Remove this before online deployment

    before_action :authenticate

    private

    def authenticate
      @session      = JwtService.decode(request.headers['access-token'])
      @current_user = User.find_by_id(@session[:user_id]) if active_session?

      return unauthorized if @current_user.nil?

      # Sliding-sessions avoid ending an active users session by sending a new token with a new expiry after some time.
      # The client is responsible for storing each new token.
      create_access_token(@current_user.id) if @session[:expiration] < (SESSION_TIMEOUT / 2).from_now
    end

    def create_access_token(user_id, remember: false)
      if remember
        expiration = REMEMBER_TIMEOUT.from_now
        deadline   = expiration
      else
        expiration = SESSION_TIMEOUT.from_now
        deadline   = @session ? @session[:deadline] : SESSION_DEADLINE.from_now
      end

      response.headers['access-token'] = JwtService.encode({ user_id: user_id,
                                                             expiration: expiration,
                                                             deadline: deadline })
    end

    def active_session?
      now = Time.now
      @session && @session[:deadline] >= now && @session[:expiration] >= now
    end

    def unauthorized
      head :unauthorized
    end
  end
end
