# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
    factory :appointment do
        time {Faker::Time.between(DateTime.now, DateTime.now + 1)}
        association :user
        factory :invalid_appointment do 
            time nil
        end
    end
end
