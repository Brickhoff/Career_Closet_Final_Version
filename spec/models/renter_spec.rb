require 'rails_helper'

RSpec.describe Renter, type: :model do
    it "is valid with valid attributes" do
        @user =User.create(:id =>1,:first_name => "Henry", :last_name => "Lin" , :uin => "123456789", :email => "hn@tamu.edu",
        :phone => "9876543210", :password => "123456", :password_confirmation => "123456")
        @suit =Suit.create(id: 1, appid: "good", size: "10", gender: "M", article: "fine", status: "Available")
        @renter = Renter.create(checkOutTime: Time.now, expectReturnTime: Time.now, returnTime: Time.now,
        status: "Available", suit_id: @suit.id, user_id: @user.id)
        expect(@renter).to be_valid
    end
    
    it "is not valid without suit_id and uer_id" do
        @user =User.create(:id =>1,:first_name => "Henry", :last_name => "Lin" , :uin => "123456789", :email => "hn@tamu.edu",
        :phone => "9876543210", :password => "123456", :password_confirmation => "123456")
        @suit =Suit.create(id: 1, appid: "good", size: "10", gender: "M", article: "fine", status: "Available")
        @renter = Renter.create(checkOutTime: Time.now, expectReturnTime: Time.now, returnTime: Time.now,
        status: "Available", suit_id: @suit.id, user_id: " ")
        
        expect(@renter).to_not be_valid
    end
end
