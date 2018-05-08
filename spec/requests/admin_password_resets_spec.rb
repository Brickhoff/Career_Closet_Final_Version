require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:last_email) { ActionMailer::Base.deliveries.last }
  it "emails admin when requesting password reset" do
    admin = FactoryGirl.create(:admin)
    visit adminlogin_path
    click_link "(forgot password)"
    fill_in "Email", :with => admin.email
    click_button "Submit"
    current_path.should eq(root_path)
    page.should have_content("Email sent with password reset instructions")
    last_email.to.should include {admin.email}
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
  it "emails admin when requesting password reset" do
    admin = FactoryGirl.create(:admin)
    visit adminlogin_path
    click_link "(forgot password)"
    fill_in "Email", :with => admin.email + "1"
    click_button "Submit"
    current_path.should eq(admin_password_resets_path)
    page.should have_content("Email address not found")
  end
  it "emails admin when requesting password reset" do
    #admin = FactoryGirl.create(:admin)
    visit adminsignup_path
    fill_in "Email", :with => "henry2@tamu.edu"
    fill_in "Name", :with => "Henry"
    fill_in "Password", :with => "123456"
    fill_in "Password Confirmation", :with => "123456"
    fill_in "Code", :with => "pXZEcKp8"
    click_button "Create my admin account"
    current_path.should eq(root_path)
    page.should have_content("Welcome to Career Closet Admin Interface! Henry")
    open_last_email
    click_first_link_in_email
    page.should have_content("Welcome to TAMU Closet! Your admin account has now been confirmed.")
  end
end