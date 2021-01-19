# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for verifying user emails
    class EmailVerificationsController < ApiController
      skip_before_action :authenticate, only: :login

      # GET /api/v1/email_verification/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.json
      def show
        @email_verification = EmailVerification.find(params[:id])
        #TODO: Update email once the new email is stored in EmailVerification
        @email_verification.user.update_attribute(:email_verified_at, Time.now)
        @email_verification.destroy
        head :ok
      end
    end
  end
end
