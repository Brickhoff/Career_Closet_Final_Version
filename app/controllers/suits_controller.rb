class SuitsController < ApplicationController
  before_action :set_suit, only: [:edit, :update, :show, :destroy]
    def index
        @suit = Suit.all
    end
    def new 
        @suit = Suit.new
    end
    
    def edit
    end
    
    def create
        @suit = Suit.new(suit_params)
        if @suit.save
            #do something
            flash[:notice] = "Suit was succussfully added to the Closet!"
            redirect_to suit_path(@suit)
        else
            render 'new'
        end
    end

    def update
        if @suit.update(suit_params)
            flash[:notice] = "Suit is succussfully updated!"
            redirect_to suit_path(@suit)
        else
            render 'edit'
        end
    end
    
    def show
        @suit = Suit.all
    end
    
    def destroy
        @suit.destroy
        flash[:notice] = "Suit is succussfully deleted!"
        redirect_to suits_path
    end
    
    private
      def set_suit
         @suit= Suit.find(params[:id])
      end
      
      def suit_params
          params.require(:suit).permit(:appid, :gender, :article, :article, :size, :user_id)
      end
end
