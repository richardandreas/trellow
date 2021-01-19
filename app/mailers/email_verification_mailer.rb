# frozen_string_literal: true

# EmailVerificationMailer
class EmailVerificationMailer < ApplicationMailer
  def send_email_verification_email_for(email_verification)
    @email_verification = email_verification

    mail(to: @email_verification.user.email, subject: I18n.t('mailer.email_verification.subject'))
  end
end
