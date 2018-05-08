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
RSpec.describe AppointmentsHelper, type: :helper do
  describe "display appointments" do
      before :each do
          user_log_in
      end
      it "with time, user and action" do
          @appointment = FactoryGirl.create(:appointment)
          visit appointments_path
          current_path.should eq(appointments_path)
          click_link "Date"
          
          
          #expect(helper.display_appointment_sorted_column_headers(@appointment)).to match ("Time")
      end
  end
end