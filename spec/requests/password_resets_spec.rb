require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:last_email) { ActionMailer::Base.deliveries.last }
  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit login_path
    click_link "(forgot password)"
    fill_in "Email", :with => user.email
    click_button "Submit"
    current_path.should eq(root_path)
    page.should have_content("Email sent with password reset instructions")
    last_email.to.should include {user.email}
    open_last_email
    click_first_link_in_email
    fill_in "Password", :with => " "
    click_button "Update password"
    page.should have_content("Reset password")
    fill_in "Password", :with => "123456"
    fill_in "Confirmation", :with => "123456"
    click_button "Update password"
    page.should have_content("Password has been reset.")
  end
  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    visit login_path
    click_link "(forgot password)"
    fill_in "Email", :with => user.email + "1"
    click_button "Submit"
    current_path.should eq(root_path)
    page.should have_content("Email address not foound")
  end
  it "emails user when requesting password reset" do
    #user = FactoryGirl.create(:user)
    visit signup_path
    fill_in "Email", :with => "henry2@tamu.edu"
    fill_in "First Name", :with => "Henry"
    fill_in "Last Name", :with => "Lin"
    fill_in "UIN", :with => "123456789"
    fill_in "Phone", :with => "1234567890"
    fill_in "Password", :with => "123456"
    fill_in "Password Confirmation", :with => "123456"
    click_button "Create my account"
    current_path.should eq(root_path)
    page.should have_content("Welcome to Career Closet Henry Lin! Please cnofirm your email address.")
    open_last_email
    click_first_link_in_email
    page.should have_content("Welcome to TAMU Closet! Your account has now been confirmed.")
  end
end