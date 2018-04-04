class RentersController < ApplicationController
  include RentersHelper
  
  require 'date'
  Time.zone = 'Central Time (US & Canada)'
  
  def index
    @q_renters = Renter.ransack(params[:q])
    @renters = @q_renters.result().paginate(page: params[:page]) || []
  end

  def show
    @renters = Renter.find(params[:id])
  end

  def new
    #save suit_id and user_id in Renter database in the samw row
    
    #renter user and suits information for confirm
    @renters = Renter.new
  end

  def edit
    @renters = Renter.find(params[:id])
  end

  def create
    @user_id = renter_params[:user_id]
    @suit_id = renter_params[:suit_id]
    if @user_id.blank?
      flash[:notice] = "Please select a customer."
      redirect_to new_renter_path
      return
    end
    if Suit.find(@suit_id).status != "Available"
      flash[:notice] = "The suit is not available."
      redirect_to new_renter_path
      return
    end
    
    #select user with user id in User database
    @user=User.find(@user_id)
    if @user.available
      @renters = Renter.new(renter_params)
      if @renters.save
        flash[:success] = "Suit is checked out."
        @suits = Suit.find(@suit_id)
        @suits.update_attribute(:status, "Checkout")
        @user.update_attribute(:available, "false")
        redirect_to @renters
      else
        redirect_to new_renter_path(:suit_id => @suit_id)
      end
    else
      flash[:notice] = "This customer has a suit in hold."
      redirect_to @user
    end
  end

  def update
    @renters = Renter.find(params[:id])
    if @renters.update(renter_params)
      flash[:notice] = "The rent was update."
      redirect_to renter_path(@renters)
    else
      render :edit
    end
  end

  def destroy
    @renters = Renter.find(params[:id])
    if User.find(@renters.user_id) && Suit.find(@renters.suit_id)
      User.find(@renters.user_id).update_attribute(:available, true)
      Suit.find(@renters.suit_id).update_attribute(:status, "Available")
      @renters.destroy
      flash[:notice] = "Rent delete"
      redirect_to renters_path
    else
      flash[:notice] = "Please Check your customer UIN ans suit ID."
      redirect_to renter_path(@renters)
    end
  end
  
  def renter_params
    params.require(:renter).permit(:checkOutTime, :pickUpTime, :expectReturnTime, :returnTime, :status, :user_id, :suit_id)
  end
end
