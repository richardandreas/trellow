# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for verifying user emails
    class EmailVerificationsController < ApiController
      skip_before_action :authenticate, only: :login
      before_action :set_email_verification, only: :show

      # GET /api/v1/email_verification/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.json
      def show
        if @email_verification.valid?
          new_attributes = { email_verified_at: Time.now }
          new_attributes.merge(email: @email_verification.new_email) if @email_verification.new_email
          @email_verification.user.update_attributes(new_attributes)
          head :ok
        else
          render json: { errors: @email_verification.errors }, status: :unprocessable_entity
        end

        @email_verification.destroy
      end

      # Use callbacks to share common setup or constraints between actions.
      def set_email_verification
        @email_verification = EmailVerification.find(params[:id])
      end
    end
  end
end
