require 'rails_helper'

describe AdminsController do
#Tesing GET methods    

    describe "GET #new" do
        it "renders the :new template" do
            get :new
            expect(response).to render_template :new
        end
    end

#Testing POST methods
    describe "POST#create" do
        context "with valid attributes" do
            it "creates a new admin" do
                expect{
                    post :create, admin: FactoryGirl.attributes_for(:admin)
                }.to change(Admin,:count).by(1)
            end
            it "redirects to the new admin" do
                post :create, admin: FactoryGirl.attributes_for(:admin)
                response.should redirect_to suits_path
            end
        end
        context "with invalid attributes" do
            it "does not save the new admin" do
                expect{
                    post :create, admin: FactoryGirl.attributes_for(:invalid_user)
                }.to_not change(Admin,:count)
            end
            it "re-renders the new methods" do
                post :create, admin: FactoryGirl.attributes_for(:invalid_user)
                response.should render_template :new
            end
        end
    end


end