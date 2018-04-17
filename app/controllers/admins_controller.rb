class AdminsController < ApplicationController
  def new
    @admins = Admin.new
  end
  
  def index
    @admins = Admin.all
  end
  
  def create
    @admins = Admin.new(admin_params)
    if @admins.save
      admin_log_in @admins
      flash[:success] = "Welcome to Career Closet Admin Interface! #{@admins.name}"
      redirect_to suits_path
    else
      render 'new'
    end
  end
  
  def edit
      @admins = Admin.find(params[:id])
  end
  def update
      @admins= Admin.find(params[:id])
      if @admins.update_attributes(admin_params)
          flash[:success] = "Your account was updated successfully."
          redirect_to suits_path
      else
          render 'edit'
      end
  end
  
  def show
      @admin = Admin.find(params[:id])
  end
  
  private
  def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation)
  end
  
end
