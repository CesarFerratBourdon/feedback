# user model
class User < ActiveRecord::Base
  rolify

  acts_as_reader

  has_attached_file :avatar, styles: { medium: '300x300#', thumb: '100x100#' }, default_url: '/images/:style/missing.png'
  validates_attachment_content_type :avatar, content_type: %r{\Aimage\/.*\Z}
  validates_with AttachmentSizeValidator, attributes: :avatar, less_than: 5.megabytes

  validates :username, presence: true
  validates_uniqueness_of :username, scope: :team_id

  # for signup
  def managers_email
    nil
  end

  def subordinates
    User.where(manager_id: id, deleted: false).order('first_name desc')
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def name_and_username
    "#{full_name.upcase} @#{username}"
  end

  def pending_invites
    invites.where(accepted: false)
  end

  def manager
    return User.find(manager_id) if manager_id
    nil
  end

  def managers_name_and_username
    if manager
      manager.name_and_username
    else
      ''
    end
  end

  def average_rating
    fbks_with_rating = feedbacks.where.not(rating: nil)
    if fbks_with_rating.count > 0
      rating_sum = fbks_with_rating.sum(:rating)
      [1, rating_sum / fbks_with_rating.count].max
    else
      5
    end
  end

  # return only open uncompleted goals
  def current_goals
    goals.where('state != \'completed\'')
  end

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable, :token_authenticatable

  has_many :feedbacks
  has_many :goals
  belongs_to :team
  has_many :invites
  has_many :replies
end
