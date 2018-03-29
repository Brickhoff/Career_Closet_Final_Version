require 'faker'

FactoryGirl.define do
    factory :user do 
        username {Faker::Name.name}
        email { Faker::Internet.email }
        UIN {Faker::Number.number(9)}
        phone {Faker::Number.number(10)}
        password 'secret'
        password_confirmation {password}
        
        factory :invalid_user do 
            username nil
        end
    end

end 