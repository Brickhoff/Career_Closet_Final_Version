class AdminPasswordResetsController < ApplicationController
  before_action :get_admin,   only: [:edit, :update]
  before_action :valid_admin, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  
  def new
  end

  def create
    @admin = Admin.find_by(email: params[:admin_password_reset][:email].downcase)
    if @admin
      @admin.create_reset_digest
      @admin.send_passward_reset_email
      flash[:success] = "Email sent with password reset instructions"
      redirect_to root_path
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  def edit
    @admin = Admin.find_by(email: params[:email])
  end
  
  def update
    if params[:admin][:password].empty?
      @admin.error.add(:password, "Please input password.")
      render 'edit'
    elsif @admin.update_attributes(admin_params)
      admin_log_in(@admin)
      flash[:success] = "Password has been reset."
      redirect_to @admin
    else
      render 'edit'
    end
    
  end
  
  private
  
    def admin_params
      params.require(:admin).permit(:password, :password_confirmation)
    end

    def get_admin
      @admin = Admin.find_by(email: params[:email])
    end

    # Confirms a valid admin.
    def valid_admin
      unless (@admin && @admin.authenticated?(:reset, params[:id]))
        redirect_to root_path
      end
    end
    
    def check_expiration
    if @admin.password_reset_expired?
      flash[:danger] = "Password reset has expired."
      redirect_to new_admin_password_reset_path
    end
  end

end
