# Reply model
class Reply < ActiveRecord::Base
  belongs_to :feedback
  belongs_to :user

  acts_as_readable on: :created_at

  after_create :send_reply_email

  def send_reply_email
    ReplyMailer.reply_email(self).deliver
  end
end
