# Goal model
class Goal < ActiveRecord::Base
  belongs_to :user
  after_create :email_goal

  acts_as_readable on: :created_at

  def creator
    User.find(creator_id)
  end

  def email_goal
    GoalMailer.goal_email(self).deliver
  end

  # Goal states (in order):
  # new - the one created already approved it; so missing one approver
  # approved - both approved the goal, and the employee has to write the self_eval
  # self_eval_completed - user has completed the self_eval, and manager has to write the manager_eval
  # manager_eval - employee has to approve the manager_eval
  # completed - both signed off on final evals
end
