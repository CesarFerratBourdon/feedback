# Sends out new goals
class GoalMailer < ApplicationMailer
  def goal_email(goal)
    @goal = goal
    mail(to: @goal.user.email, subject: 'Feedbk: New Goal') do |format|
      format.html { render layout: 'mailer.html.erb' }
      format.text { render layout: 'mailer.text.erb' }
    end
  end
end
