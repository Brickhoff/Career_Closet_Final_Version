require 'faker'

FactoryGirl.define do
    factory :suit do
        appid "ABC 12"
        gender "M"
        size {Faker::Number.number(1)}
        description "It's a good suit!"

        factory :invalid_suit do 
            appid nil
        end
    end

end 