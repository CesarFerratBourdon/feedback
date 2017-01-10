# Handles user registration and updates
class Users::RegistrationsController < Devise::RegistrationsController
  include ApplicationHelper
  skip_authorization_check

  api :POST, '/users/role/:role/', 'Create a user'
  formats ['json']
  param :role, ['admin', 'manager', 'employee'], desc: 'The new user\'s role.', required: true
  param :user, Hash do
    param :first_name, String, required: true
    param :last_name, String, required: true
    param :email, String, required: true
    param :password, String, desc: 'Must be at least 8 characters', required: true
    param :password_confirmation, String, desc: 'Must be at least 8 characters', required: true
    param :job_title, String, required: true
    param :username, String, desc: 'Must be unique team-wide', required: true
    param :team_size, ['1', '6', '21'], desc: 'Required if role is admin.'
  end
  param :company, Hash do
    param :Company, String, desc: 'The company\'s name.  Required if role is admin.'
  end
  def create
    @user = User.new(sign_up_params)
    @team_created = false

    # store role in instance variable so we can change it if the user signed up on the /employee page but checked the box labled "i am a manager"
    @role = params[:role]

    if params[:user][:invite_id]
      return false unless handle_user_invitation
    else
      return false unless handle_no_invitation
    end
    @user.team = @team
    save_new_user
  end

  def invite_email_signup
    sign_out current_user if user_signed_in?
    @invite = Invite.find(params[:id])
    new
  end

  def new
    super
  end

  def edit
    super
  end

  private

  def handle_no_invitation
    if params[:role] == 'admin'
      return false unless create_team_for_admin
    else
      # user is not an admin, check for the "i am a a manager" checkbox and override the role passed in by params
      @role = 'manager' if params['signup'] && params['signup']['is_manager'] && params['signup']['is_manager'] == 'on'
      return false unless set_team_for_non_admin
    end
    true
  end

  def set_team_for_non_admin
    if params[:user][:managers_email]
      company_domain = params[:user][:managers_email].split('@')[1].downcase
      @team = Team.find_by(domain_name: company_domain)
      # find team based on managers email
      unless @team
        respond_to do |format|
          format.html { redirect_to :back, flash: { error: 'Your company has not been created yet.  Please sign up as an admin.' } }
          format.json { render json: { error: 'Your company has not been created yet.  Please sign up as an admin.' }, status: :bad_request }
        end
        return false
      end
      return false unless set_manager
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: { error: 'You must enter your manager\'s email if you are not an admin' } }
        format.json { render json: { error: 'You must enter your manager\'s email if you are not an admin' }, status: :bad_request }
      end
      return false
    end
    true
  end

  def set_manager
    # find manager based on managers email
    manager = User.find_by(email: params[:user][:managers_email])
    unless manager
      respond_to do |format|
        format.html { redirect_to :back, flash: { error: 'The email you entered for you manager is not registered.  Please check your managers email address.' } }
        format.json { render json: { error: 'The email you entered for you manager is not registered.  Please check your managers email address.' }, status: :bad_request }
      end
      return false
    end
    @user.manager_id = manager.id
    true
  end

  def create_team_for_admin
    if @user.email
      # does team already exist or is domain banned?
      company_domain = @user.email.split('@')[1].downcase
      return false if email_domain_is_banned?(company_domain)
      @team = Team.find_by(domain_name: company_domain)
      return false unless team_does_not_exist_yet
      @team = Team.create(domain_name: company_domain, name: params[:company][:Company], team_size: params[:user][:team_size])
      @team_created = true
    end
    true
  end

  def email_domain_is_banned?(company_domain)
    banned_list = ['gmail.com', 'yahoo.com', 'hotmail.com', 'aol.com']
    if banned_list.include?(company_domain)
      respond_to do |format|
        format.html { redirect_to :back, flash: { error: "Your cannot create a team using an address from #{company_domain}.  Please use your company email address to create a team." } }
        format.json { render json: { error: "Your cannot create a team using an address from #{company_domain}.  Please use your company email address to create a team." }, status: :bad_request }
      end
      return true
    end
    false
  end

  def team_does_not_exist_yet
    if @team
      respond_to do |format|
        format.html { redirect_to :back, flash: { error: 'Your company is already registered' } }
        format.json { render json: { error: 'Your company is already registered' }, status: :bad_request }
      end
      return false
    end
    true
  end

  def handle_user_invitation
    # this registration comes with an invite.  assign team based on the invite.
    @invite = Invite.where(id: params[:user][:invite_id]).includes(:user)
    if @invite
      @invite = @invite.first
      invite_creator = @invite.user
      @team = invite_creator.team
      @user.manager_id = invite_creator.id
      @invite.accepted = true
      @invite.save
    else
      respond_to do |format|
        format.html { redirect_to :back, flash: { error: 'An error occured.  Your invite_id is invalid' } }
        format.json { render json: { error: 'An error occured.  Your invite_id is invalid' }, status: :bad_request }
      end
      return false
    end
    true
  end

  def save_new_user
    if @user.save
      user_saved
    else
      @team.destroy if @team_created
      if @invite
        @invite.accepted = false
        @invite.save
      end
      respond_to do |format|
        flash[:error] = validation_error_to_error_message(@user.errors)
        format.html { render :new }
        format.json { render json: { error: validation_error_to_error_message(@user.errors) }, status: :bad_request }
      end
    end
  end

  def user_saved
    if @team_created
      @team.creator_id = @user.id
      @team.save
    end
    @user.add_role @role
    sign_in @user
    # nag the user to set their photo
    respond_to do |format|
      format.html { redirect_to set_photo_path, flash: { success: 'You successfully signed up' } }
      format.json { render json: { success: true }, status: :created }
    end
  end

  def sign_up_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :job_title, :username)
  end
end
