require 'rails_helper'
require 'spec_helper'
include SpecTestHelper

# Specs in this file have access to a helper object that includes
# the HistoriesHelper. For example:
#
# describe HistoriesHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe HistoriesHelper, type: :helper do
  describe "display histories" do
      before :each do
          admin_log_in
      end
      it "with sorting method" do
          @history = FactoryGirl.create(:history)
          visit histories_path
          current_path.should eq(histories_path)
          click_link "App. ID"
      end
  end
end
