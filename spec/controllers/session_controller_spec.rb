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
         FactoryGirl.create(:user, id: 1, email: "henry@tamu.edu", password: "123456", remember_token: '1' )
      end
      it "redirects to appointment page" do
        puts "henry@tamu.edu" + " " + "123456"
        expect(response).to redirect_to appointments_path
      end
    end
    
    context "session create test" do
      before :each do
          @user = FactoryGirl.create(:user)
          post :create, { session: { email: " ", password: " " }}
      end
      it "redirects to session page" do
        puts @user.email + " " + " "
        expect(response).to render_template('session/new')
      end
    end
  end
  
end