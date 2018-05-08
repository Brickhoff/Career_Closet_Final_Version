class SuitsController < ApplicationController
    include SuitsHelper
    
    #before_action :set_suit, only: [:edit, :update, :show, :destroy]
    
    # GET /suits
    # GET /suits.json
    def index
        @search = Suit.ransack(params[:q])
        @suits = @search.result.paginate(page: params[:page], :per_page => 10)
        
    end
    
    
    # GET /suits/1
    # GET /suits/1.json
    def show
        @suit = Suit.find(params[:id])
    end
    
    
    # GET /suits/new
    def new 
        @suit = Suit.new
    end
    
    
    # GET /suits/1/edit
    def edit
        @suit = Suit.find(params[:id])
    end
    
    
    def create
        @suit = Suit.new(suit_params)
        if @suit.save
            flash[:success] = "Suit was succussfully added to the Closet!"
            redirect_to suit_path(@suit)
        else
            render 'new'
        end
    end
    def update
        @suit = Suit.find(params[:id])
        if @suit.update(suit_params)
            flash[:success] = "Suit was succussfully updated"
            redirect_to suit_path(@suit)
        else
            render 'edit'
        end
    end

    
    def destroy
        @suit =Suit.find(params[:id])
        @renter = Renter.where(suit_id: @suit.id)
        if @renter.blank? && @suit.status != "Checkout"
            @suit.destroy
            flash[:success] = "Suit was succussfully deleted"
            redirect_to suits_path
        elsif @suit.status == "Checkout"
            flash[:danger] = "Suit cannnot be deleted, Please return the suit."
            redirect_to suits_path
        end
    end
    
    private
      #def set_suit
         # @suit= Suit.find(params[:id])
      #end
      
      def suit_params
          params.require(:suit).permit(:appid, :gender, :size, :article, :status)
      end
end
