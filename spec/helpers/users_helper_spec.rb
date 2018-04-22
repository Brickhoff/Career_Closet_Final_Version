require 'rails_helper'
require 'spec_helper'
include SpecTestHelper

# Specs in this file have access to a helper object that includes
# the RentersHelper. For example:
#
# describe RentersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe "display uers" do
      before :each do
          admin_log_in
      end
      it "with sorting method" do
          @user = FactoryGirl.create(:user)
          visit users_path
          current_path.should eq(users_path)
          click_link "First Name"
      end
  end
end