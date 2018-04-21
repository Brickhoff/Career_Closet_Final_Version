class AdminsController < ApplicationController
  def new
    @admin = Admin.new
  end
  
  def index
    @admins = Admin.all
  end
  
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      admin_log_in @admin
      flash[:success] = "Welcome to Career Closet Admin Interface! #{@admin.name}"
      redirect_to suits_path
    else
      render 'new'
    end
  end
  
  def edit
      @admin = Admin.find(params[:id])
  end
  def update
      @admin= Admin.find(params[:id])
      if @admin.update_attributes(admin_params)
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
