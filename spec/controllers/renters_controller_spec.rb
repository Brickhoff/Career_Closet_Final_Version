require 'rails_helper'

RSpec.describe RentersController, type: :controller do

  describe "GET #index" do
    it "populates an array of renters" do
      renter = FactoryGirl.create(:renter)
      get :index
      assigns(:renters).should eq([renter])
    end
    it "renders the :index template" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "GET #show" do
    it "assigns the requested renter to @renter" do
        renter = FactoryGirl.create(:renter)
        get :show, params: { id: renter.id}
        assigns(:renter).should eq(renter)
    end
    
    it "renders the :show template" do
        get :show, params: {id: FactoryGirl.create(:renter)}
        expect(response).to render_template :show
    end
  end

  describe "GET #new" do
    it "assigns a new renter to @renter" do
        get :new
        assigns(:renter).should be_a_new(Renter)
    end
    
    it "renders the :new template" do
        get :new
        expect(response).to render_template :new
    end
  end

  describe "GET #edit" do
    it "assigns the requested renter to @renter" do
        renter = FactoryGirl.create(:renter)
        get :show, params: { id: renter.id}
        assigns(:renter).should eq(renter)
    end
    it "renders the :edit template" do
        get :edit, params: { id: FactoryGirl.create(:renter)}
        expect(response).to render_template :edit
    end
    
  end

  describe "POST#create" do
        context "with valid attributes" do
            it "creates a new renter" do
                expect{
                    post :create, params:{ renter: FactoryGirl.build(:renter).attributes.except('id', 'created_at', 'updated_at')}
                }.to change(Renter,:count).by(1)
            end
            it "redirects to the new renter" do
                post :create, params:{ renter: FactoryGirl.build(:renter).attributes.except('id', 'created_at', 'updated_at')}
                response.should redirect_to Renter.last
            end
        end
        context "with invalid attributes" do
            it "does not save the new rneter" do
                expect{
                    post :create, params:{ renter: FactoryGirl.build(:invalid_renter).attributes.except('id', 'created_at', 'updated_at')}
                }.to_not change(Renter,:count)
            end
            it "re-renders the new methods" do
                post :create, params:{ renter: FactoryGirl.build(:invalid_renter).attributes.except('id', 'created_at', 'updated_at')}
                response.should redirect_to new_renter_path
            end
            it "re-renders the new methods due to suit was Checkout" do
                FactoryGirl.create(:suit, id:1, status: "Checkout")
                post :create, params:{ renter: FactoryGirl.build(:renter, suit_id: 1).attributes.except('id', 'created_at', 'updated_at')}
                response.should redirect_to new_renter_path
            end
            it "re-renders the new methods due to customer has over two suits" do
                FactoryGirl.create(:user, id:1, suitCount: 2)
                post :create, params:{ renter: FactoryGirl.build(:renter, user_id: 1).attributes.except('id', 'created_at', 'updated_at')}
                response.should redirect_to renters_path
            end
        end
  end

#Testing PUT methods
    describe 'PUT update' do
        before :each do
            admin_log_in
            FactoryGirl.create(:user, id:1)
            FactoryGirl.create(:suit, id:1)
            FactoryGirl.create(:renter, id: 1, user_id: 1, suit_id: 1)
            FactoryGirl.create(:history, id: 1, user_id: 1, suit_id: 1)
            @renter = FactoryGirl.create(:renter, expectReturnTime: Time.now, user_id: 1, suit_id: 1)
        end
        
        context "valid attributes" do
            it "located the requested @renter" do
                
                put :update, params: { id: @renter.id, 
                     renter: FactoryGirl.attributes_for(:renter)}
                assigns(:renter).should eq(@renter)
            end
            
            it "changes @renter's attributes" do
                put :update, params: { id: @renter,
                    renter: FactoryGirl.attributes_for(:renter, expectReturnTime: Time.now.to_s)}
                @renter.reload
                @renter.expectReturnTime.should eq(Time.now.to_s)
            end
            
            it "redirects to the updated renter" do
                put :update, params: {id: @renter,
                    renter: FactoryGirl.attributes_for(:renter)}
                    response.should redirect_to @renter
            end
        end
        
        context "invalid attributes" do
            it "locates the requested @renter" do
                put :update, params: {id: @renter,
                    renter: FactoryGirl.attributes_for(:invalid_renter)}
                assigns(:renter).should eq(@renter)
            end
            
            it "does not change @renter's attributes" do
                put :update, params: {id: @renter,
                    renter: FactoryGirl.attributes_for(:renter, expectReturnTime: Time.now.to_s)}
                @renter.reload
                @renter.expectReturnTime.should eq(Time.now.to_s)
            end
            
            it "re-renders the edit method" do
                put :update, params: {id: @renter,
                    renter: FactoryGirl.attributes_for(:invalid_renter)}
                    response.should render_template :edit
            end
        end
    end
#Testing DELETE methods
    describe 'DELETE destroy' do
        before :each do
             admin_log_in
            FactoryGirl.create(:user, id:1)
            FactoryGirl.create(:suit, id:1)
            FactoryGirl.create(:renter, id: 1, user_id: 1, suit_id: 1)
            FactoryGirl.create(:history, id: 1, user_id: 1, suit_id: 1)
            @renter = FactoryGirl.create(:renter, expectReturnTime: Time.now, user_id: 1, suit_id: 1)
        end
        
        it "deletes the contact" do
            expect{
                delete :destroy, params:{ id: @renter}
            }.to change(Renter,:count).by(-1)
        end
        
        it "redirects to contacts#index" do
            delete :destroy, params: { id: @renter}
            response.should redirect_to renters_url
        end
    end

end
