require 'rails_helper'

RSpec.describe Appointment, type: :model do

    subject {described_class.new(time: Faker::Time.between(DateTime.now, DateTime.now + 1), user_id: 1)}
    describe "Validations" do
        it "is valid with valid attributes" do
            User.create(:id =>1,:first_name => "Henry", :last_name => "Lin" , :uin => "123456789", :email => "hn@tamu.edu",
            :phone => "9876543210", :password => "123456", :password_confirmation => "123456")
            expect(subject).to be_valid
        end
        it "is not valid without a user" do
            subject.user_id = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a time" do
            subject.time= nil
            expect(subject).to_not be_valid
        end
    end
end
