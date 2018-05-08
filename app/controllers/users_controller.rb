class UsersController < ApplicationController
  include UsersHelper
  
  before_action :logged_in_user, only: [:edit, :update]
  before_action :correct_user,   only: [:edit, :update]

  def new
    @user = User.new
  end
  
  def index
    @q_user = User.ransack(params[:q])
    @users = @q_user.result().paginate(page: params[:page], :per_page => 10) || []
  end
  
  def edit
      @user = User.find(params[:id])
  end
  
  def create
        @user = User.new(user_params)
        if @user.save
            UserMailer.registration_confirmation(@user).deliver
            flash[:success] = "Welcome to Career Closet #{@user.full_name}! Please cnofirm your email address."
            #user_log_in @user
            redirect_to root_path
        else
            flash[:error] = "Please confirm your registration."
            render 'new'
        end
  end
  
  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.email_activate
      flash[:success] = "Welcome to TAMU Closet! Your account has now been confirmed."
      redirect_to root_path
    else
      flash[:error] = "User does not exist."
      redirect_to signup_path
    end
  end
  
  
  def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
          flash[:success] = "Your account was updated successfully"
          redirect_to appointments_path if user_logged_in?
          redirect_to users_path if admin_logged_in? 
      else
          render 'edit'
      end
  end
  
  def show
      @user = User.find(params[:id])
  end
  
  def destroy
    @user = User.find(params[:id])
    @renter = Renter.where(user_id: @user.id)
    @history = History.where(user_id: @user.id)
    if @renter.blank? && @history.blank?
      @user.destroy
      flash[:success] = "The customer data is delete."
    else
      flash[:danger] = "Before you delete this customer please remove his or her history and rental record."
    end
    redirect_to users_path
  end
  
  
  
  
  private
  def user_params
      params.require(:user).permit(:first_name, :last_name, :uin, :phone, :email, :password, :password_confirmation)
  end
  
  def logged_in_user
    if !(user_logged_in? || admin_logged_in?)
      flash[:danger] = "You must be logged in to perform that action"
      redirect_to root_path
    end
  end
  
  def correct_user
    if !current_user && !current_admin
      flash[:danger] = "You can only edit or delete your own appointments."
      redirect_to root_path
    end
  end
  
end
