class Admin::BaseController < ApplicationController
  before_action :require_login
 
  private

  def logged_in?
    uid = session[:uid]
    if uid and User.valid_user?(uid)
      return true
    else
      return false
    end
  end
 
  def require_login
    if not logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to admin_signin_path
    end
  end
end
