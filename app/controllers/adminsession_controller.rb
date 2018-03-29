class AdminsessionController < ApplicationController
  def new
  end
  
  def create
    admin = Admin.find_by(email: params[:session][:name])
   
    if admin && admin.authenticate(params[:session][:password])
      admin_log_in admin
      admin_remember admin
      redirect_to suits_path
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
