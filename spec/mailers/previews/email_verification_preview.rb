# Preview all emails at http://localhost:3000/rails/mailers/email_verification
class EmailVerificationPreview < ActionMailer::Preview
  def send_mail
    EmailVerificationMailer.send_email_verification_email_for(EmailVerification.last)
  end
end
