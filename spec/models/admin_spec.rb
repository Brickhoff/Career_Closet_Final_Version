require 'rails_helper'

RSpec.describe Admin, :type => :model do
    subject {described_class.new(name: "Henry",  email:"hn@tamu.edu",
      password: "123456", password_confirmation: "123456")}
    describe "Validations" do
        it "is valid with valid attributes" do
            expect(subject).to be_valid
        end
        it "is not valid without a name" do
            subject.name = nil
            expect(subject).to_not be_valid
        end
        it "is not valid without an email" do
            subject.email = nil
            expect(subject).to_not be_valid
        end
        it "is not valid with an invalid password" do
            subject.password = "123"
            expect(subject).to_not be_valid
        end
    end
end