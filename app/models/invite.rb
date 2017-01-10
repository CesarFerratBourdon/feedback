# Invite model class
class Invite < ActiveRecord::Base
  belongs_to :user
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true

  after_create :send_invite_email

  def send_invite_email
    InviteMailer.invite_email(self).deliver
  end
end
