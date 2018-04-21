require 'faker'

FactoryGirl.define do
    factory :user do 
        first_name {Faker::Name.first_name}
        last_name {Faker::Name.last_name}
        email { Faker::Internet.email }
        uin {Faker::Number.number(9)}
        phone {Faker::Number.number(10)}
        password 'secret'
        password_confirmation {password}
        email_confirmed {true}
        
        factory :invalid_user do 
            username nil
        end
    end

end 