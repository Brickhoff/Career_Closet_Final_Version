require 'rails_helper'

RSpec.describe Suit, :type => :model do
    subject { described_class.new }
    it "is valid with valid attributes" do
        subject.appid = "Anything"
        subject.size = "Anything"
        subject.gender = "Anything"
        expect(subject).to be_valid
    end
    it "is not valid without an appid" do
        expect(subject).to_not be_valid
    end
    it "is not valid without a size" do
        subject.appid = "Anthing"
        expect(subject).to_not be_valid
    end
    it "is not valid without a gender" do
        subject.appid = "Anthing"
        subject.size = "Anything"
        expect(subject).to_not be_valid
    end
end