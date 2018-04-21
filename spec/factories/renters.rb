# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :renter do
    checkOutTime {Faker::Time.between(DateTime.now-1, DateTime.now)}
    expectReturnTime {Faker::Time.forward(10, :morning)}
    returnTime {Faker::Time.forward(8, :morning)}
    status "Available"
    association :user
    association :suit
    factory :invalid_renter do 
            user_id nil
        end
  end
end
