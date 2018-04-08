class UsersController < ApplicationController
  include UsersHelper

  def new
    @users = User.new
  end
  
  def index
    @q_user = User.ransack(params[:q])
    @users = @q_user.result().paginate(page: params[:page], :per_page => 30) || []
  end
  
  def edit
      @users = User.find(params[:id])
  end
  
  def create
        @users = User.new(user_params)
        if @users.save
            flash[:notice] = "Welcome to Career Closet #{@users.full_name}"
            redirect_to users_path(@users)
        else
            render 'new'
        end
  end
  
  def update
      @users = User.find(params[:id])
      if @users.update_attributes(user_params)
          flash[:success] = "Your account was updated successfully"
          redirect_to appointments_path if user_logged_in?
          redirect_to users_path if admin_logged_in? 
      else
          render 'edit'
      end
  end
  
  def show
      @users = User.find(params[:id])
  end
  
  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :uin, :phone, :email, :password, :password_confirmation)
  end
  
end
