class UsersController < ApplicationController
  def new
    @user = User.new
  end
  
  def index
    @user = User.all
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to Career Closet #{@user.first_name}"
      redirect_to appointments_path
    else
      render 'new'
    end
  end
  
  def edit
      @user = User.find(params[:id])
  end
  def update
      @user = User.find(params[:id])
      if @user.update(user_params)
          flash[:success] = "Your account was updated successfully"
          redirect_to appointments_path
      else
          render 'edit'
      end
  end
  
  def show
      @user = User.find(params[:id])
  end
  
  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :UIN, :phone, :email, :password, :password_confirmation)
  end
  
end
