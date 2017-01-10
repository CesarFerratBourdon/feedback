# Sends reply emails
class ReplyMailer < ApplicationMailer
  default from: ENV['MAILGUN_FROM_ADDRESS']

  def reply_email(reply)
    @reply = reply
    mail(from: ENV['MAILGUN_FROM_ADDRESS'], to: reply.feedback.user.email, subject: "Feedbk Reply from #{reply.user.name_and_username}") do |format|
      format.html { render layout: 'mailer.html.erb' }
      format.text { render layout: 'mailer.text.erb' }
    end
  end
end
