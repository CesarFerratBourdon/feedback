class UserMailer < Devise::Mailer
  default from: ENV['MAILGUN_FROM_ADDRESS']
  layout 'mailer.html.erb'

end