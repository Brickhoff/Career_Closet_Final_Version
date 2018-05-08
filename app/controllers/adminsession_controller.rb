class AdminsessionController < ApplicationController
  def new
  end
  
  def create
    admin = Admin.find_by(email: params[:session][:email])
   
    if admin && admin.authenticate(params[:session][:password])
       if admin.email_confirmed
          admin_log_in admin
          params[:session][:remember_me] == '1' ? admin_remember(admin) : admin_forget(admin)
          flash[:success] = "Welcome to Career Closet."
          redirect_to suits_path
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
    admin_log_out if admin_logged_in?
    redirect_to adminlogin_path
  end
  
end
