class AdminsController < ApplicationController
  
  before_action :logged_in_as_admin, only: [:show, :edit, :update]
  before_action :logged_in_as_superadmin, only:[:index, :destroy]
  
  
  def new
    @admin = Admin.new
  end
  
  def index
    @q_admin = Admin.ransack(params[:q])
    @admins = @q_admin.result().paginate(page: params[:page], :per_page => 10) || []
  end
  
  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      UserMailer.admin_registration_confirmation(@admin).deliver
      #admin_log_in @admin
      flash[:success] = "Welcome to Career Closet Admin Interface! #{@admin.name}"
      redirect_to root_path
    else
      flash[:error] = "Please confirm your registration."
      render 'new'
    end
  end
  
  def confirm_email
    @admin = Admin.find_by_confirm_token(params[:id])
    if @admin
      @admin.email_activate
      flash[:success] = "Welcome to TAMU Closet! Your admin account has now been confirmed."
      redirect_to root_path
    else
      flash[:error] = "Admin does not exist."
      redirect_to signup_path
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
  
  def destroy
    @admin = Admin.find(params[:id])
    if !@admin.superadmin?
      @admin.destroy
      flash[:success] = "The admin is delete."
    else
      flash[:danger] = "You can not delete super admin account."
    end
    redirect_to admins_path
  end
  
  private
  
  def admin_params
      params.require(:admin).permit(:name, :email, :password, :password_confirmation, :code)
  end
  
end
