# Sends invite emails
class InviteMailer < ApplicationMailer
  def invite_email(invite)
    if invite.is_manager
      role = 'manager'
    else
      role = 'employee'
    end
    # @invite_url = "http://#{host_with_port}/invite_email_signup/#{role}/#{invite.id}"
    @invite_url = invite_email_registration_url(role, invite)
    @current_user = invite.user
    mail(from: ENV['MAILGUN_FROM_ADDRESS'], to: invite.email, subject: 'You\'re invited to Feedbk!') do |format|
      format.html { render layout: 'mailer.html.erb' }
      format.text { render layout: 'mailer.text.erb' }
    end
  end
end
