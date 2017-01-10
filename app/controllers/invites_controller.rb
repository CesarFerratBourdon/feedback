# All operations for invites
class InvitesController < ApplicationController
  authorize_resource except: [:invite_form, :resend]

  api :POST, '/invites', 'Create a new email invitation'
  formats ['json']
  param :auth_token, String, desc: 'User is logged in with auth token', required: true
  param :invite, Hash do
    param :first_name, String
    param :last_name, String
    param :email, String
    param :is_manager, [true, false], desc: 'Whether or not the invited user will be a manager'
  end
  def create
    # first, check if the user already exists, and is deleted
    return if user_already_exists
    return if invite_already_exists
    invite = Invite.new(invite_params.merge(user: current_user))
    respond_to do |format|
      if invite.save
        format.html { redirect_to dashboard_path, flash: { notice: "User with email #{invite_params[:email]} was invited" } }
        format.json { render json: invite }
      else
        respond_to_validation_error(format: format, model: invite)
      end
    end
  end

  def invite_form
    @invite = Invite.new
  end

  api :POST, '/invites/:invite_id/resend', 'Resend an email invitation'
  formats ['json']
  param :auth_token, String, desc: 'User is logged in with auth token', required: true
  param :invite_id, String, desc: 'The invite id obtained from the team page', required: true
  def resend
    invite = Invite.find(params[:invite_id])
    InviteMailer.invite_email(invite).deliver
    respond_to do |format|
      format.html { redirect_to dashboard_path, flash: { notice: "User with email #{invite.email} was invited" } }
      format.json { render json: invite }
    end
  end

  private

  def user_already_exists
    @possible_user = User.find_by(email: params[:invite][:email])
    return false unless @possible_user
    if @possible_user.deleted
      undelete_user
    else
      # notify the user's current manager that they should delete the user
      notify_manager_of_theft_attempt
    end
    true
  end

  def invite_already_exists
    invite = Invite.find_by(email: params[:invite][:email])
    return false unless invite
    respond_to do |format|
      format.html { redirect_to team_path, flash: { error: "User with email #{invite_params[:email]} has already been invited." } }
      format.json { render json: { error: "User with email #{invite_params[:email]} has already been invited" }, status: :bad_request }
    end
    true
  end

  def notify_manager_of_theft_attempt
    ManagerNotificationMailer.notify_of_user_stealing_email(current_user: current_user, user_being_stolen: @possible_user, host_with_port: request.host_with_port).deliver
    respond_to do |format|
      format.html { redirect_to team_path, flash: { error: "User with email #{invite_params[:email]} is already on a team.  Their current manager has been notified." } }
      format.json { render json: { error: "User with email #{invite_params[:email]} is already on a team.  Their current manager has been notified." }, status: :bad_request }
    end
  end

  def undelete_user
    # undelete this user, and change their team
    @possible_user.deleted = false
    @possible_user.manager_id = current_user.id
    respond_to do |format|
      if @possible_user.save
        format.html { redirect_to team_path, flash: { notice: "User with email #{invite_params[:email]} was added to your team" } }
        format.json { render json: { notice: "User with email #{invite_params[:email]} was added to your team" } }
      else
        format.html { redirect_to :back, flash: { error: 'User invitation failed' } }
        format.json { render json: { error: 'User invitation failed' }, status: :bad_request }
      end
    end
  end

  def invite_params
    params.require(:invite).permit(:first_name, :last_name, :email, :is_manager)
  end
end
