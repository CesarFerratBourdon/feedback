# base mailer class from which all others inherit
class ApplicationMailer < ActionMailer::Base
  default from: ENV['MAILGUN_FROM_ADDRESS']
  layout 'mailer.html.erb'
end
