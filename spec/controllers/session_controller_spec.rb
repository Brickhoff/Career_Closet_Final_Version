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
          post :create, { session: { email: @user.email, password: @user.password }}
      end
      it "redirects to suits page" do
        puts @user.email + " " + @user.password
        expect(response).to redirect_to user_path(@user)
      end
    end
    context "session create test" do
      before :each do
          @user = FactoryGirl.create(:user)
          post :create, { session: { email: " ", password: " " }}
      end
      it "redirects to suits page" do
        puts @user.email + " " + " "
        expect(response).to render_template('session/new')
      end
    end
  end
end