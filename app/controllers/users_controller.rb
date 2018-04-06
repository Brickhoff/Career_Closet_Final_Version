class UsersController < ApplicationController

  def new
    @user = User.new
  end
  
  def index
       redirect = false
    
    if params[:commit]
      @commit = params[:commit]
    else 
      @commit = nil
    end
    
    if @commit == "Clear" 
      # flash.delete
      session[:sort_by] = nil
      session[:type] = nil
      session[:search] = nil
      redirect_to users_path :sort_by=>nil,:type => nil,:search => nil
      return
    end
    
    # if params[:search]
    #   @user = User.search(params[:type],params[:search])
    # else 
    #   @user = User.all
    # end
    
    
    # if params[:sort_by]
    #   @sort_by = params[:sort_by]
    # end
    # if @sort_by
    #   @user = @user.order(@sort_by).all
    # end
    
    if params[:type] and params[:search]
      @type = params[:type] 
      session[:type] = params[:type]
      @search = params[:search] 
      session[:search] = params[:search]
    elsif session[:type] and session[:search]
      @type = session[:type] 
      @search = session[:search]
      redirect = true
    else
      @type = nil
      @search = nil
    end
      
    if params[:sort_by]
      @sort_by = params[:sort_by]
      session[:sort_by] = params[:sort_by]
    elsif session[:sort_by]
      @sort_by = session[:sort_by]
      redirect = true
    else
      @sort_by = nil
    end  
    
    if redirect 
      flash.keep
      redirect_to users_path :sort_by=>@sort_by,:type => @type,:search => @search
    end
    
    
    if @search and @type and @sort_by
      @user = User.search(@type,@search).order(@sort_by).all
    elsif @search and @type
      @user = User.search(@type,@search)
    elsif @sort_by
      @user = User.order(@sort_by).all
    else 
      @user = User.all
    end
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      user_log_in @user
      flash[:success] = "Welcome to Career Closet #{@user.full_name}"
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
      if @user.update_attributes(user_params)
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
      params.require(:user).permit(:first_name, :last_name, :uin, :phone, :email, :password, :password_confirmation)
  end
  
end
