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
            admin = Admin.create(id: 1, name: "Henry",  email:"hn@tamu.edu",
                                password: "123456", password_confirmation: "123456", code: "pXZEcKp8", email_confirmed: true)
            get :show, params: { id: admin.id}
            assigns(:admin).should eq(admin)
        end
        
        it "renders the :show template" do
            admin = Admin.create(id: 1, name: "Henry",  email:"hn@tamu.edu",
                                password: "123456", password_confirmation: "123456", code: "pXZEcKp8", email_confirmed: true)
            get :show, params: { id: admin.id}
            expect(response).to render_template :show
        end
    end
    
    describe "GET#edit" do
        before :each do
            admin_log_in
        end
        it "assigns the requested admin to @admin" do
            admin = Admin.create(id: 1, name: "Henry",  email:"hn@tamu.edu",
                                password: "123456", password_confirmation: "123456", code: "pXZEcKp8", email_confirmed: true)
            get :show, params: { id: admin.id}
            assigns(:admin).should eq(admin)
        end
        it "renders the :edit template" do
            admin = Admin.create(id: 1, name: "Henry",  email:"hn@tamu.edu",
                                password: "123456", password_confirmation: "123456", code: "pXZEcKp8", email_confirmed: true)
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
                response.should redirect_to root_path
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
    
    describe 'PUT update' do
        before :each do
            admin_log_in
            @admin = Admin.create(id: 1, name: "Henry",  email:"hn@tamu.edu",
                                password: "123456", password_confirmation: "123456", code: "pXZEcKp8", email_confirmed: true)
        end
        
        context "valid attributes" do
            it "located the requested @admin" do
                put :update, params: { id: @admin.id, admin: FactoryGirl.attributes_for(:admin)}
                assigns(:admin).should eq(@admin)
            end
            
            it "changes @admin's attributes" do
                put :update, params: { id: @admin.id, admin: FactoryGirl.attributes_for(:admin, name: "Henry2") }
                    #params: {admin: FactoryGirl.attributes_for(:admin, uin: 928009988)}
                @admin.reload
                @admin.name.should eq("Henry2")
            end
            
            it "redirects to admins page" do
                put :update, params: { id: @admin.id, admin: FactoryGirl.attributes_for(:admin)}
                    response.should redirect_to suits_url
            end
        end
        
        context "invalid attributes" do
            it "locates the requested @admin" do
                put :update, params: { id: @admin.id, admin: FactoryGirl.attributes_for(:invalid_admin)}
                assigns(:admin).should eq(@admin)
            end
            
            it "does not change @admin's attributes" do
                put :update, params: { id: @admin.id, admin: FactoryGirl.attributes_for(:admin, name: "Henry2") }
                @admin.reload
                @admin.name.should eq("Henry2")
            end
            
            it "redirect_to admins page" do
                put :update, params: { id: @admin.id, admin: FactoryGirl.attributes_for(:invalid_admin)}
                    response.should render_template 'edit'
            end
        end
    end
#Testing DELETE methods
    describe 'DELETE destroy' do
        before :each do
            Admin.create(id: 1, name: "Henry",  email:"hn@tamu.edu", password: "123456",
            password_confirmation: "123456", code: "pXZEcKp8", email_confirmed: true, superadmin: true)
            @admin2 =Admin.create(id: 3, name: "Henry",  email:"hn@tamu.edu", password: "123456",
            password_confirmation: "123456", code: "BsvKCFDT", email_confirmed: true, superadmin: false)
            @admin = Admin.create(id: 1, name: "Henry",  email:"hn@tamu.edu", password: "123456",
            password_confirmation: "123456", code: "pXZEcKp8", email_confirmed: true, superadmin: true)
            session[:admin_id] = @admin.id
        end
        
        it "deletes the contact" do
            expect{
                delete :destroy, params: {id: @admin}
            }.to change(Admin,:count).by(0)
        end
        
        it "redirects to contacts#index" do
            delete :destroy, params: {id: @admin}
            response.should redirect_to admins_url
        end
    end
end