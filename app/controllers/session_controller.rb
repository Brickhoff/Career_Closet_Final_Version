class SessionController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
   
    if user && user.authenticate(params[:session][:password])
      user_log_in user
      user_remember user
      redirect_to appointments_path
    else
      flash[:error] = "Invalid combination of email and password."
      render 'new'
    end
  end
  
  def destroy
    user_log_out if user_logged_in?
    redirect_to login_path
  end
  
end
