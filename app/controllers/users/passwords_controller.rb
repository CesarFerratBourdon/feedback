# For setting user passwords
class Users::PasswordsController < Devise::PasswordsController
  include ApplicationHelper
  skip_authorization_check

  def new
    super
  end
end
