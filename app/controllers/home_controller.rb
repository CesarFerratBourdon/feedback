# actions for the lamding page
class HomeController < ApplicationController
  def index
    return unless user_signed_in?
    if current_user.deleted
      # tell the user they're deleted and need to be reassigned
      current_user_is_deleted
      return
    end
    if current_user.has_role?(:employee)
      redirect_to user_feedbacks_path(current_user)
    else
      redirect_to team_path
    end
  end

  def dashboard
    return unless require_user_signed_in
    redirect_to team_path
  end

  def you_were_removed
    # this should already have been done, but just in case
    sign_out current_user if user_signed_in?
  end
end
