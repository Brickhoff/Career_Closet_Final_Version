# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
    factory :appointment do
        time Time.now
        slot "9:00 am"
        user_id 1
        association :user
        factory :invalid_appointment do 
            time nil
        end
    end
end
