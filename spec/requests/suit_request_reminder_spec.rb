require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:last_email) { ActionMailer::Base.deliveries.last }
  it "emails user when requesting password reset" do
    user = FactoryGirl.create(:user)
    suit = FactoryGirl.create(:suit)
    renter = FactoryGirl.create(:renter)
    visit renter_path(renter)
    current_path.should eq(renter_path(renter))
    click_button "Remind cutomer to return the suit."
    page.should have_content('Reminder is send!')
    last_email.to.should include {user.email}
  end
end