require 'rails_helper'

describe AdminsessionController do

  describe 'GET #new' do
    it "renders the login page" do
      get :new
      expect(response).to render_template('adminsession/new')
    end
  end
 
  describe 'POST #create' do
    context "session create test" do
      before :each do
          @admin = FactoryGirl.create(:admin)
          post :create, { session: { email: @admin.email, password: @admin.password }}
      end
      it "redirects to suits page" do
        puts @admin.email + " " + @admin.password
        expect(response).to redirect_to suits_path
      end
    end
    context "session create test" do
      before :each do
          @admin = FactoryGirl.create(:admin)
          post :create, { session: { email: " ", password: " " }}
      end
      it "redirects to suits page" do
        puts @admin.email + " " + " "
        expect(response).to render_template('adminsession/new')
      end
    end
  end

end