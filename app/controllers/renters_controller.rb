class RentersController < ApplicationController
  include RentersHelper
  
  require 'date'
  Time.zone = 'Central Time (US & Canada)'
  
  def index
    @q_renters = Renter.ransack(params[:q])
    @renters = @q_renters.result.includes(:user, :suit).paginate(page: params[:page], :per_page => 30) || []
  end

  def show
    @renter = Renter.find(params[:id])
    @user = User.find(@renter.user_id)
    @suit = Suit.find(@renter.suit_id)
  end

  def new
    #save suit_id and user_id in Renter database in the samw row
    
    #renter user and suits information for confirm
    @renter = Renter.new
  end

  def edit
    @renter = Renter.find(params[:id])
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
    if @user.suitCount < 2
      @renter = Renter.new(renter_params)
      if @renter.save
        flash[:success] = "Suit is checked out."
        @suit = Suit.find(@suit_id)
        @suit.update_attribute(:status, "Checkout")
        @user.update_attribute(:suitCount, @user.suitCount + 1)
        create_rental_history(@user_id, @suit_id, Time.now, @renter.expectReturnTime) #history record
        UserMailer.suit_rental(@user,@suit,@renter).deliver
        redirect_to @renter
      else
        redirect_to new_renter_path(:suit_id => @suit_id)
      end
    else
      flash[:notice] = "This customer has two suit in hold."
      redirect_to renters_path
    end
  end
  
  #rental history
  def create_rental_history(user_id,suit_id,checkOutTime, expectReturnTime)
    @rental_history = History.new
    @rental_history.user_id = user_id
    @rental_history.suit_id = suit_id
    @rental_history.checkOutTime = checkOutTime
    @rental_history.expectReturnTime =expectReturnTime
    @rental_history.save!
  end

  def update
    @renter = Renter.find(params[:id])
    if @renter.update(renter_params)
      update_book_history(@renter.user_id, @renter.suit_id,@renter.checkOutTime, @renter.expectReturnTime)
      flash[:notice] = "The rental information is update."
      redirect_to renter_path(@renter)
    else
      render :edit
    end
  end
  
  def update_book_history(user_id, suit_id, checkOutTime, expectReturnTime)
    @rental_history = History.find_by(:suit_id => suit_id, :user_id => user_id)
    @rental_history.checkOutTime = checkOutTime
    @rental_history.expectReturnTime = expectReturnTime
    @rental_history.save!
  end

  def destroy
    @renter = Renter.find(params[:id])
    if User.find(@renter.user_id) && Suit.find(@renter.suit_id)
      @user = User.find(@renter.user_id)
      User.find(@renter.user_id).update_attribute(:suitCount, @user.suitCount - 1)
      Suit.find(@renter.suit_id).update_attribute(:status, "Available")
      Renter.find(@renter.id).update_attribute(:returnTime, Time.now)
      
      @user = User.find(@renter.user_id)
      @suit = Suit.find(@renter.suit_id)
      @renters = Renter.find(@renter.id)
      complete_book_history(@renter.user_id, @renter.suit_id)
      UserMailer.suit_return(@user,@suit,@renters).deliver
      @renter.destroy
      flash[:notice] = "Suit is returned to Closet!"
      redirect_to renters_path
    else
      flash[:notice] = "Please Check your customer UIN ans suit ID."
      redirect_to renter_path(@renter)
    end
  end
  
  def complete_book_history(user_id, suit_id)
    @rental_history = History.find_by(:suit_id => suit_id, :user_id => user_id)
    @rental_history.returnTime = Time.now
    @rental_history.save!
  end
  
  def remind
    @renter = Renter.find(params[:id])
    @user = User.find(@renter.user_id)
    @suit = Suit.find(@renter.suit_id)
    @renters = Renter.find(@renter.id)
    flash[:success] = 'Reminder is send!'
    UserMailer.suit_return_reminder(@user,@suit,@renters).deliver
    redirect_to renters_path
  end
  
  private
  def renter_params
    params.require(:renter).permit(:checkOutTime, :expectReturnTime, :returnTime, :status, :user_id, :suit_id)
  end
end
