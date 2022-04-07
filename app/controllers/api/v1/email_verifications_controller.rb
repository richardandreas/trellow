# frozen_string_literal: true

module Api
  module V1
    # Controller responsible for verifying user emails and updating them
    class EmailVerificationsController < ApiController
      skip_before_action :authenticate, only: :show
      before_action :set_email_verification, only: :show

      # GET /api/v1/email_verification/aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa.json
      def show
        if @email_verification.confirm
          head :ok
        else
          render json: { errors: @email_verification.errors }, status: :unprocessable_entity
        end
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_email_verification
        @email_verification = EmailVerification.find_by!(uuid: params[:uuid])
      end
    end
  end
end
