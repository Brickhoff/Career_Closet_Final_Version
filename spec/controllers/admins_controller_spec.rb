require 'rails_helper'
require 'spec_helper'

describe AdminsController do
#Tesing GET methods    

    describe "GET #new" do
        it "assigns a new admin to @admin" do
            get :new
            assigns(:admin).should be_a_new(Admin)
        end
        it "renders the :new template" do
            get :new
            expect(response).to render_template :new
        end
    end
    
    describe "GET #show" do
        before :each do
            admin_log_in
        end
        it "assigns the requested admin to @admin" do
            admin = FactoryGirl.create(:admin)
            get :show, params: { id: admin.id}
            assigns(:admin).should eq(admin)
        end
        
        it "renders the :show template" do
            admin = FactoryGirl.create(:admin)
            get :show, params: { id: admin.id}
            expect(response).to render_template :show
        end
    end
    
    describe "GET#edit" do
        before :each do
            admin_log_in
        end
        it "assigns the requested admin to @admin" do
            admin = FactoryGirl.create(:admin)
            get :show, params: { id: admin.id}
            assigns(:admin).should eq(admin)
        end
        it "renders the :edit template" do
            admin = FactoryGirl.create(:admin)
            get :edit, params: { id: admin.id}
            expect(response).to render_template :edit
        end
    end

#Testing POST methods
    describe "POST#create" do
        context "with valid attributes" do
            it "creates a new admin" do
                expect{
                    post :create, params: {admin: FactoryGirl.attributes_for(:admin)}
                    #post :create, admin: FactoryGirl.attributes_for(:admin)
                }.to change(Admin,:count).by(1)
            end
            it "redirects to the new admin" do
                post :create, params: {admin: FactoryGirl.attributes_for(:admin)}
                response.should redirect_to suits_path
            end
        end
        context "with invalid attributes" do
            it "does not save the new admin" do
                expect{
                    post :create, params: {admin: FactoryGirl.attributes_for(:invalid_admin)}
                }.to_not change(Admin,:count)
            end
            it "re-renders the new methods" do
                post :create, params: {admin: FactoryGirl.attributes_for(:invalid_admin)}
                response.should render_template :new
            end
        end
    end
end