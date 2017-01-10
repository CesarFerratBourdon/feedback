# Handles update, edit, destroy and the team page for a user
class UsersController < AuthorizedController
  # manually handle auth checks in this class
  skip_authorization_check

  def_param_group :auth_and_user do
    param :auth_token, String, desc: 'User is logged in with auth token', required: true
    param :user_id, String, desc: 'The user being referenced', required: true
  end

  api :GET, '/team', 'Lists all team members for a user'
  formats ['json']
  param_group :auth_and_user
  example <<-EOT
  Response:
  {
    "members": [
      {
        "id": "c756f7dc-632e-4ab5-904d-33f9f0a25b94",
        "email": "bsimpson@gmail.com",
        "created_at": "2015-12-11T01:08:59.362Z",
        "updated_at": "2015-12-21T04:53:08.907Z",
        "first_name": "bart",
        "last_name": "simpson",
        "username": "bsimpson",
        "team_id": 1,
        "avatar_file_name": null,
        "avatar_content_type": null,
        "avatar_file_size": null,
        "avatar_updated_at": null,
        "manager_id": "327592a3-04a0-4907-a174-588aa64abbba",
        "job_title": "Troublemaker",
        "deleted": false,
        "authentication_token": "sA4bFV1sn_eKPnTFUTwm"
      }
    ],
    "pending_invites": [
      {
        "id": "e4da2527-d808-4a93-99b1-dd484ab04bbc",
        "user_id": "327592a3-04a0-4907-a174-588aa64abbba",
        "first_name": "John",
        "last_name": "Smith",
        "email": "jsmith@gmail.com",
        "created_at": "2015-12-17T01:59:35.834Z",
        "updated_at": "2015-12-17T01:59:35.834Z",
        "is_manager": false,
        "accepted": false
      }
    ]
  }
  EOT
  def team
    @team = current_user.team
  end

  def edit
    user_is_editing_self
  end

  api :PUT, '/users/:user_id', 'Update a user'
  formats ['json']
  param_group :auth_and_user
  param :user, Hash do
    param :avatar, File
    param :first_name, String
    param :last_name, String
    param :job_title, String
    param :username, String
    param :password, String
    param :password_confirmation, String
  end
  def update
    return unless user_is_editing_self

    # change user password if needed
    return unless check_if_changing_password

    respond_to do |format|
      if @user.update(user_update_params)
        format.html { redirect_to dashboard_path, flash: { notice: 'Account successfuly changed' } }
        format.json { render json: @user }
      else
        respond_to_validation_error(format: format, model: @user)
      end
    end
  end

  api :DELETE, '/users/:user_id', 'Remove a user from the team'
  formats ['json']
  param_group :auth_and_user
  def destroy
    @user = User.find_by(id: params[:id])
    # make sure current user has permissions
    if @user.manager_id == current_user.id
      if @user
        mark_user_as_deleted
      else
        flash[:error] = 'User not found'
        flash.keep(:error)
        render json: { success: false, error: flash[:error] }, status: :bad_request
      end
    else
      flash[:error] = 'You can only delete members of your team'
      flash.keep(:error)
      render json: { success: false, error: flash[:error] }, status: :bad_request
    end
  end

  private

  def mark_user_as_deleted
    @user.deleted = true
    if @user.save
      flash[:notice] = 'User removed from team'
      flash.keep(:notice)
      render json: { success: true }, status: :bad_request
    else
      flash[:error] = 'User could not be saved'
      flash.keep(:error)
      render json: { success: false, error: flash[:error] }, status: :bad_request
    end
  end

  def check_if_changing_password
    if !params[:user][:password].nil? && params[:user][:password].length != 0
      return false unless change_password
    end
    true
  end

  def change_password
    respond_to do |format|
      if @user.valid_password?(params[:user][:current_password])
        if @user.update(password_update_params)
          sign_in @user, bypass: true
        else
          respond_to_validation_error(format: format, model: @user)
          return false
        end
      else
        format.html { redirect_to :back, flash: { error: 'You entered the wrong current password' } }
        format.json { render json: { error: 'You entered the wrong current password' } }
        return false
      end
    end
    true
  end

  def user_is_editing_self
    @user = User.find(params[:id])
    return true unless @user != current_user
    respond_to do |format|
      format.html { redirect_to :back, flash: { error: 'Error.  You cannot edit users that are not yourself' } }
      format.json { render json: { error: 'Error.  You cannot edit users that are not yourself' }, status: :bad_request }
    end
    false
  end

  def password_update_params
    params.require(:user).permit(:password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:avatar, :first_name, :last_name, :job_title, :username)
  end
end
