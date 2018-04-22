require 'rails_helper'
require 'spec_helper'


describe UsersController do
#Tesing GET methods    
    describe "GET #index" do
        before :each do
            admin_log_in
        end
        it "populates an array of users" do
            user = FactoryGirl.create(:user)
            get :index
            assigns(:users).should eq([user])
        end
        it "renders the :index template" do
            get :index
            expect(response).to render_template :index
        end
    end
    
    describe "GET #show" do
        it "assigns the requested user to @user" do
            user = FactoryGirl.create(:user)
            #get :show, id: user
            get :show, params: { id: user.id}
            assigns(:user).should eq(user)
        end
        
        it "renders the :show template" do
            #get :show, id: FactoryGirl.create(:user)
            user = FactoryGirl.create(:user)
            get :show, params: { id: user.id}
            expect(response).to render_template :show
        end
    end
    
    describe "GET #new" do
        it "assigns a new user to @user" do
            get :new
            assigns(:user).should be_a_new(User)
        end
        
        it "renders the :new template" do
            get :new
            expect(response).to render_template :new
        end
    end
    
    describe "GET#edit" do
        before :each do
            admin_log_in
        end
        it "assigns the requested user to @user" do
            user = FactoryGirl.create(:user)
            get :show, params: { id: user.id}
            assigns(:user).should eq(user)
        end
        it "renders the :edit template" do
            user = FactoryGirl.create(:user)
            get :edit, params: { id: user.id}
            expect(response).to render_template :edit
        end
    end
    
#Testing POST methods
    describe "POST#create" do
        context "with valid attributes" do
            it "creates a new user" do
                expect{
                    post :create, params: {user: FactoryGirl.attributes_for(:user)}
                }.to change(User,:count).by(1)
            end
            it "redirects to the new user" do
                post :create, params: {user: FactoryGirl.attributes_for(:user)}
                response.should redirect_to root_url
            end
        end
        context "with invalid attributes" do
            it "redirect_to root page" do
                post :create, params: {user: FactoryGirl.attributes_for(:invalid_user)}
                response.should redirect_to root_url
            end
        end
    end
#Testing PUT methods
    describe 'PUT update' do
        before :each do
            admin_log_in
            @user = FactoryGirl.create(:user, uin: "927001413")
        end
        
        context "valid attributes" do
            it "located the requested @user" do
                put :update, params: { id: @user.id, user: FactoryGirl.attributes_for(:user)}
                    #params: {user: FactoryGirl.attributes_for(:user)}
                assigns(:user).should eq(@user)
            end
            
            it "changes @user's attributes" do
                put :update, params: { id: @user.id, user: FactoryGirl.attributes_for(:user, uin: 928009988) }
                    #params: {user: FactoryGirl.attributes_for(:user, uin: 928009988)}
                @user.reload
                @user.uin.should eq("928009988")
            end
            
            it "redirects to users page" do
                put :update, params: { id: @user.id, user: FactoryGirl.attributes_for(:user)}
                    response.should redirect_to users_url
            end
        end
        
        context "invalid attributes" do
            it "locates the requested @user" do
                put :update, params: { id: @user.id, user: FactoryGirl.attributes_for(:invalid_user)}
                assigns(:user).should eq(@user)
            end
            
            it "does not change @user's attributes" do
                put :update, params: { id: @user.id, user: FactoryGirl.attributes_for(:user, uin: 928009988) }
                @user.reload
                @user.uin.should eq("928009988")
            end
            
            it "redirect_to users page" do
                put :update, params: { id: @user.id, user: FactoryGirl.attributes_for(:invalid_user)}
                    response.should redirect_to users_url
            end
        end
    end
#Testing DELETE methods
    describe 'DELETE destroy' do
        before :each do
            admin_log_in
            @user = FactoryGirl.create(:user)
        end
        
        it "deletes the contact" do
            expect{
                delete :destroy, params: {id: @user}
            }.to change(User,:count).by(-1)
        end
        
        it "redirects to contacts#index" do
            delete :destroy, params: {id: @user}
            response.should redirect_to users_url
        end
    end
end