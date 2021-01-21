# Preview all emails at http://localhost:3000/rails/mailers/email_verification
class EmailVerificationPreview < ActionMailer::Preview
  def send_mail
    EmailVerificationMailer.email_verification_mail(EmailVerification.last)
  end
end
