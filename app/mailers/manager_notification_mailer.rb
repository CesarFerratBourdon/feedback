# Tells a manager that someone tried to invite their employee
class ManagerNotificationMailer < ApplicationMailer
  default from: ENV['MAILGUN_FROM_ADDRESS']

  def notify_of_user_stealing_email(current_user:, user_being_stolen:, host_with_port:)
    @current_user = current_user
    @user_being_stolen = user_being_stolen
    @host_with_port = host_with_port
    mail(from: ENV['MAILGUN_FROM_ADDRESS'], to: user_being_stolen.manager.email, subject: 'New Feedbk Notification') do |format|
      format.html { render layout: 'mailer.html.erb' }
      format.text
    end
  end
end
