class SessionController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
   
    if user && user.authenticate(params[:session][:password])
      if user.email_confirmed
        user_log_in user
        params[:session][:remember_me] == '1' ? user_remember(user) : user_forget(user)
        flash[:success] = "Welcome to Career Closet."
        redirect_to appointments_path
      else
        flash[:error] = "Please activate your account."
        redirect_to root_path
      end
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
