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
          post :create, params:{ session: { email: @admin.email, password: @admin.password }}
      end
      it "redirects to suits page" do
        puts @admin.email + " " + @admin.password
        expect(response).to redirect_to suits_path
      end
    end
    context "session create test" do
      before :each do
          @admin = FactoryGirl.create(:admin)
          post :create, params:{ session: { email: @admin.email, password: " " }}
      end
      it "redirects to new page" do
        puts " " + " " + " "
        expect(response).to render_template('adminsession/new')
      end
    end
  end
  
#Testing DELETE methods
  describe 'DELETE destroy' do
      before :each do
           admin_log_in
      end
      it "redirects to contacts#index" do
          delete :destroy, params: { admin_id: 1}
          response.should redirect_to adminlogin_path
      end
  end

end
