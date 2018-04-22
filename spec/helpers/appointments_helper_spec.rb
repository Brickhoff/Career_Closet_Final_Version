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
      it "with time, user and action" do
          admin_log_in
          user_log_in
          visit appointments_path
          current_path.should eq(appointments_path)
          @appointment = FactoryGirl.create(:appointment)
          click_link "Gender"
          
          
          #expect(helper.display_appointment_sorted_column_headers(@appointment)).to match ("Time")
      end
  end
end