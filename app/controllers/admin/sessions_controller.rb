class Admin::SessionsController < Admin::BaseController
  skip_before_action :require_login, only: [:new, :create]
  layout false

  def new
  end

  def create
    email = params[:session][:email]
    password = params[:session][:password]
    if User.valid_password(email, password)
      session[:uid] = email
      redirect_to admin_products_path
    else
      flash.now[:notice] = "Invalid Username or Password"
      render 'new'
    end
  end

  def destroy
    session.delete :uid
    redirect_to admin_signin_path
  end
end
