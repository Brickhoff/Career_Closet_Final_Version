require 'rails_helper'

RSpec.describe User, :type => :model do
    subject {described_class.new(username: "Henry", UIN:"123456789", email:"hn@tamu.edu",
    phone: "9876543210", password: "123456", password_confirmation: "123456")}
    describe "Validations" do
        it "is valid with valid attributes" do
            expect(subject).to be_valid
        end
        it "is not valid without a username" do
            subject.username = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a UIN" do
            subject.UIN = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without an email" do
            subject.email = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without a phone" do
            subject.phone = nil
            expect(subject).to_not be_valid
        end
        it "is not valid with an invalid password" do
            subject.password = "123"
            expect(subject).to_not be_valid
        end
    end
end