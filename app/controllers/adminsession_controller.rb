class AdminsessionController < ApplicationController
  def new
  end
  
  def create
    admin = Admin.find_by(email: params[:session][:name])
   
    if admin && admin.authenticate(params[:session][:password])
      log_in admin
      redirect_to suits_path
    else
      flash[:error] = "Invalid combination of email and password."
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to adminlogin_path
  end
  
end
