# All controllers that have fully authenticated endpoints can inherit from this controller
class AuthorizedController < ApplicationController
  before_filter :require_user_signed_in
  check_authorization
end
