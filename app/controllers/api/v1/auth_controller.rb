# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for authentication of application users
    class AuthController < ApiController
      skip_before_action :authenticate, only: :login

      # POST /api/v1/auth.json
      def login
        @user = User.find_by_email(auth_params[:email])

        unless @user&.authenticate(auth_params[:password])
          return render json: { errors: { email: [I18n.t('errors.messages.invalid_auth')] } },
                        status: :unprocessable_entity
        end

        unless @user.email_verified?
          return render json: { errors: { email: [I18n.t('errors.messages.email_not_verified')] } },
                        status: :unprocessable_entity
        end

        create_access_token(@user.id, remember: auth_params[:remember])
        render json: @user, except: :password_digest, status: :ok
      end

      def session
        render json: current_user, except: :password_digest, status: :ok
      end

      private

      # Only allow a list of trusted parameters through.
      def auth_params
        params.permit(:email, :password, :remember)
      end
    end
  end
end
