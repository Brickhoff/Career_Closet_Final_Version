require 'rails_helper'

describe SessionController, type: :controller do
  describe 'GET #new' do
    it "renders the login page" do
      get :new
      expect(response).to render_template('session/new')
    end
  end
  describe 'POST #create' do
   
    context "session create test" do
       before :each do
         @user = FactoryGirl.create(:user)
         post :create, params:{session: {email: @user.email, password: @user.password}}
      end
      it "redirects to appointment page" do
        puts @user.email + " " + @user.password
        expect(response).to redirect_to appointments_path
      end
    end
    
    context "session create test" do
      before :each do
          @user = FactoryGirl.create(:user)
          post :create, params: { session: { email: " ", password: " " }}
      end
      it "redirects to session page" do
        puts @user.email + " " + " "
        expect(response).to render_template('session/new')
      end
    end
  end
  
#Testing DELETE methods
  describe 'DELETE destroy' do
      before :each do
           user_log_in
      end
      it "redirects to contacts#index" do
          delete :destroy, params: { user_id: 1}
          response.should redirect_to login_path
      end
  end
  
end