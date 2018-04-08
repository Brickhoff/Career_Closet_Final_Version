class SuitsController < ApplicationController
    include SuitsHelper
    
    #before_action :set_suit, only: [:edit, :update, :show, :destroy]
    
    # GET /suits
    # GET /suits.json
    def index
        @search = Suit.ransack(params[:q])
        @suits = @search.result.paginate(page: params[:page], :per_page => 30)
        
    end
    
    
    # GET /suits/1
    # GET /suits/1.json
    def show
        @suits = Suit.find(params[:id])
    end
    
    
    # GET /suits/new
    def new 
        @suits = Suit.new
    end
    
    
    # GET /suits/1/edit
    def edit
        @suits = Suit.find(params[:id])
    end
    
    
    def create
        @suits = Suit.new(suit_params)
        if @suits.save
            flash[:notice] = "Suit was succussfully added to the Closet!"
            redirect_to suit_path(@suits)
        else
            render 'new'
        end
    end
    def update
        @suits = Suit.find(params[:id])
        if @suits.update(suit_params)
            flash[:notice] = "Suit was succussfully updated"
            redirect_to suit_path(@suits)
        else
            render 'edit'
        end
    end

    
    def destroy
        @suits =Suit.find(params[:id])
        @renters = Renter.where(suit_id: @suits.id)
        if @renters.blank?
            @suits.destroy
            flash[:success] = "Suit was succussfully deleted"
            redirect_to suits_path
        else
            flash[:success] = "Suit cannnot be deleted, Please return the suit."
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
=begin
      def can_destroy
        @suits = Suit.find(params[:id])  
        renter_is_exist = Renter.where(suit_id: @suits.id).where.not(rentStatus:['Complete','Cancel']).size !=0
        if @suits.status != "Available" || renter_is_exist
            flash[:danger] = "This suit is in use. It cannot be deleted!"
            redirect_to suit_path
        end
      end
=end
end
