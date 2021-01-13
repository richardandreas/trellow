# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for authentication of application users
    class AuthController < ApiController
      skip_before_action :authenticate, only: :login

      # POST /api/v1/auth.json
      def login
        @user = User.find_by_email(auth_params[:email])

        if @user&.authenticate(auth_params[:password])
          create_access_token(@user.id)
          render json: @user, except: :password_digest, status: :ok
        else
          render json: { errors: { email: [I18n.t('errors.messages.invalid_auth')] } }, status: :unprocessable_entity
        end
      end

      def user
        render json: current_user, except: :password_digest, status: :ok
      end

      private

      def auth_params
        params.permit(:email, :password)
      end
    end
  end
end
