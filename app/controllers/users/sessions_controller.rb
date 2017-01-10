# Basic session class for devise.  Nothing special or custom.
class Users::SessionsController < Devise::SessionsController
  include ApplicationHelper
  skip_authorization_check
  respond_to :json

  api :POST, '/users/sign_in', 'Sign in'
  formats ['json']
  param :user, Hash do
    param :email, String, required: true
    param :password, String, required: true
  end
  example <<-EOT
  Response:
  {
    "id": "327592a3-04a0-4907-a174-588aa64abbba",
    "email": "rwiggum@gmail.com",
    "created_at": "2015-12-09T05:28:25.198Z",
    "updated_at": "2015-12-21T03:15:44.799Z",
    "first_name": "Ralph",
    "last_name": "Wiggum",
    "username": "rwiggum",
    "team_id": 1,
    "avatar_file_name": "HappyCat.png",
    "avatar_content_type": "image/png",
    "avatar_file_size": 944948,
    "avatar_updated_at": "2015-12-09T05:43:23.470Z",
    "manager_id": "a3db9a59-594c-4bd1-917a-7766cbca09d7",
    "job_title": "Meow Co",
    "deleted": false,
    "authentication_token": "t48ArfuJhFfRm7pE3gdu"
  }
  EOT
  def create
    super
  end

  api :DELETE, '/users/sign_out', 'Sign out'
  formats ['json']
  param :auth_token, String, desc: 'User is logged in with auth token', required: true
  def destroy
    current_user.update(authentication_token: nil)
    super
  end

  private

  # Check if there is no signed in user before doing the sign out.
  #
  # If there is no signed in user, it will set the flash message and redirect
  # to the after_sign_out path.
  def verify_signed_out_user
    # this respond_to fixes the fact that json sign out doesn't work at all with devise
    respond_to do |format|
      format.html do
        if all_signed_out?
          set_flash_message :notice, :already_signed_out if is_flashing_format?

          respond_to_on_destroy
        end
      end
      format.json { return true }
    end
  end
end
