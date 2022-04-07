# frozen_string_literal: true

# ApplicationMailer
class ApplicationMailer < ActionMailer::Base
  default from: 'richardapidev@gmail.com'
  layout 'mailer'
end
