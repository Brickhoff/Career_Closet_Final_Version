class PasswordResetsController < ApplicationController
  before_action :set_user, only:[:edit, :update]
  before_action :correct_user, only:[:edit, :update]
  before_action :check_expiration, only: [:edit, :update]
  
  def new
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
      @user.create_reset_digest
      @user.send_passward_reset_email
      flash[:success] = "Email sent with password reset instructions"
      redirect_to root_path
    else
      flash[:danger] = "Email address not foound"
      redirect_to root_path
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.error.add(:password, "Please input password.")
      render 'edit'
    elsif @user.update_attributes(user_params)
      user_log_in(@user)
      @user.update_attribute(:reset_digest, nil)
      flash[:success] = "Password has been reset."
      redirect_to @user
    else
      render 'edit'
    end
    
  end
  
  private
  
  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  
  
  def set_user
    @user = User.find_by(email: params[:email])
  end
  
  def correct_user
     unless (@user && @user.authenticated?(:reset, params[:id]))
        redirect_to root_path
     end
  end
  
  def check_expiration
    if @user.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_password_reset_path
    end
  end
end
