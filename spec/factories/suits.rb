require 'faker'

FactoryGirl.define do
    factory :suit do
        appid {Faker::Number.number(3)}
        gender "M"
        size {Faker::Number.number(1)}
        article "It's a good suit!"
        status "Available"

        factory :invalid_suit do 
            appid nil
        end
    end

end 