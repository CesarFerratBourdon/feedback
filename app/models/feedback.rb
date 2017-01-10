# Feedback model
class Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :goal
  has_many :replies
  after_create :email_feedback

  acts_as_readable on: :created_at

  def feedback_with_sender
    sender_username = 'UnknownUser'
    sender_username = User.find(sender_id).username if sender_id
    "from @#{sender_username}: #{comment}"
  end

  def sender
    User.find(sender_id)
  end

  def email_feedback
    FeedbackMailer.feedback_email(self).deliver
  end
end
