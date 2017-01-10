# Sends out emails with new feedbk
class FeedbackMailer < ApplicationMailer
  def feedback_email(feedback)
    @feedback = feedback
    email_parts = ENV['MAILGUN_FROM_ADDRESS'].split('@')
    address_with_id = "#{email_parts[0]}+#{feedback.id}@#{email_parts[1]}"
    mail(from: address_with_id, to: @feedback.user.email, subject: "New Feedbk from #{feedback.sender.name_and_username}") do |format|
      format.html { render layout: 'mailer.html.erb' }
      format.text { render layout: 'mailer.text.erb' }
    end
  end
end
