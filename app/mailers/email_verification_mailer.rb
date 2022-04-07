# frozen_string_literal: true

# EmailVerificationMailer
class EmailVerificationMailer < ApplicationMailer
  def email_verification_mail(email_verification)
    @email_verification = email_verification

    mail(to: @email_verification.user.email, subject: I18n.t('mailer.email_verification.subject'))
  end
end
