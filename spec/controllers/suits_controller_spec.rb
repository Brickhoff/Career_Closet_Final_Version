require 'rails_helper'

describe SuitsController do
#Tesing GET methods    
    describe "GET #index" do
        before :each do
            admin_log_in
        end
        it "populates an array of suits" do
            suit = FactoryGirl.create(:suit)
            get :index
            assigns(:suits).should eq([suit])
        end
        it "renders the :index template" do
            get :index
            expect(response).to render_template :index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested suit to @suit" do
            suit = FactoryGirl.create(:suit)
            get :show, params: { id: suit.id}
            assigns(:suit).should eq(suit)
        end
        
        it "renders the :show template" do
            get :show, params: {id: FactoryGirl.create(:suit)}
            expect(response).to render_template :show
        end
    end
    
    describe "GET #new" do
        it "assigns a new suit to @suit" do
            get :new
            assigns(:suit).should be_a_new(Suit)
        end
        
        it "renders the :new template" do
            get :new
            expect(response).to render_template :new
        end
    end
    
    describe "GET#edit" do
        it "assigns the requested suit to @suit" do
            suit = FactoryGirl.create(:suit)
            get :show, params: { id: suit.id}
            assigns(:suit).should eq(suit)
        end
        it "renders the :edit template" do
            get :edit, params: { id: FactoryGirl.create(:suit)}
            expect(response).to render_template :edit
        end
    end
    
#Testing POST methods
    describe "POST#create" do
        context "with valid attributes" do
            it "creates a new suit" do
                expect{
                    post :create, params:{ suit: FactoryGirl.attributes_for(:suit)}
                }.to change(Suit,:count).by(1)
            end
            it "redirects to the new suit" do
                post :create, params:{ suit: FactoryGirl.attributes_for(:suit)}
                response.should redirect_to Suit.last
            end
        end
        context "with invalid attributes" do
            it "does not save the new suit" do
                expect{
                    post :create, params:{ suit: FactoryGirl.attributes_for(:invalid_suit)}
                }.to_not change(Suit,:count)
            end
            it "re-renders the new methods" do
                post :create, params:{ suit: FactoryGirl.attributes_for(:invalid_suit)}
                response.should render_template :new
            end
        end
    end
#Testing PUT methods
    describe 'PUT update' do
        before :each do
            admin_log_in
            @suit = FactoryGirl.create(:suit, appid: "123")
        end
        
        context "valid attributes" do
            it "located the requested @suit" do
                put :update, params: { id: @suit, 
                    suit: FactoryGirl.attributes_for(:suit)}
                assigns(:suit).should eq(@suit)
            end
            
            it "changes @suit's attributes" do
                put :update, params: { id: @suit,
                    suit: FactoryGirl.attributes_for(:suit, appid: "123")}
                @suit.reload
                @suit.appid.should eq("123")
            end
            
            it "redirects to the updated suit" do
                put :update, params: {id: @suit,
                    suit: FactoryGirl.attributes_for(:suit)}
                    response.should redirect_to @suit
            end
        end
        
        context "invalid attributes" do
            it "locates the requested @suit" do
                put :update, params: {id: @suit,
                    suit: FactoryGirl.attributes_for(:invalid_suit)}
                assigns(:suit).should eq(@suit)
            end
            
            it "does not change @suit's attributes" do
                put :update, params: {id: @suit,
                    suit: FactoryGirl.attributes_for(:suit, appid: "123")}
                @suit.reload
                @suit.appid.should eq("123")
            end
            
            it "re-renders the edit method" do
                put :update, params: {id: @suit,
                    suit: FactoryGirl.attributes_for(:invalid_suit)}
                    response.should render_template :edit
            end
        end
    end
#Testing DELETE methods
    describe 'DELETE destroy' do
        before :each do
            @suit = FactoryGirl.create(:suit)
        end
        
        it "deletes the contact" do
            expect{
                delete :destroy, params:{ id: @suit}
            }.to change(Suit,:count).by(-1)
        end
        
        it "redirects to contacts#index" do
            delete :destroy, params: { id: @suit}
            response.should redirect_to suits_url
        end
    end
    
    describe 'DELETE destroy(sad path)' do
        before :each do
            @suit = FactoryGirl.create(:suit, status:"Checkout")
        end
        it " cannot deletes the contact" do
            expect{
                delete :destroy, params:{ id: @suit}
            }.to change(Suit,:count).by(0)
        end
        it "redirects to contacts#index" do
            delete :destroy, params: { id: @suit}
            response.should redirect_to suits_url
        end
    end
end


