class SessionController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by(email: params[:session][:email].downcase)
   
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to appointment_path
    else
      flash[:error] = "Invalid combination of email and password."
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to login_path
  end
  
end
