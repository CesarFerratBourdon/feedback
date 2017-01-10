# The main controller class from which all other controllers inherit
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def json_request?
    request.format.json?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:login, :username, :email, :password, :remember_me) }
  end

  private

  def require_user_signed_in
    if !user_signed_in?

      # If the user came from a page, we can send them back.  Otherwise, send
      # them to the root path.
      if request.env['HTTP_REFERER']
        fallback_redirect = :back
      elsif defined?(root_path)
        fallback_redirect = root_path
      else
        fallback_redirect = '/'
      end
      respond_to do |format|
        format.html { redirect_to fallback_redirect, flash: { error: 'You must be signed in to view this page.' } }
        format.json { render json: { error: 'You must be signed in to view this page' }, status: :bad_request }
      end
      return false
    else
      if current_user.deleted
        # tell the user they're deleted and need to be reassigned
        current_user_is_deleted
        return false
      end
      true
    end
  end

  def current_user_is_deleted
    sign_out current_user
    respond_to do |format|
      format.html { redirect_to you_were_removed_path }
      format.json { render json: { error: 'Your account was removed from your team by your manager.  You must contact a manager and have them invite you to their team.' }, status: :bad_request }
    end
  end

  def validation_error_to_error_message(errors)
    # get first error
    key, msg = errors.messages.first
    if key
      "An error occured: #{key} #{msg.first}"
    else
      'Unknown error'
    end
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def render_json_validation_error(model_with_errors)
    render json: { error: validation_error_to_error_message(model_with_errors.errors) }, status: :bad_request
  end

  def redirect_back_validation_error(model_with_errors)
    redirect_to :back, flash: { error: validation_error_to_error_message(model_with_errors.errors) }
  end

  def respond_to_validation_error(format:, model:)
    format.html { redirect_back_validation_error(model) }
    format.json { render_json_validation_error(model) }
  end
end
