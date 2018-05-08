require 'faker'

FactoryGirl.define do
    factory :admin do 
        name {Faker::Name.name}
        email { Faker::Internet.email }
        password 'secret'
        password_confirmation {password}
        code 'pXZEcKp8'
        email_confirmed {true}
        factory :invalid_admin do 
            name nil
        end
    end

end