# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :history do
    suit nil
    user nil
    checkOutTime "2018-04-13 21:21:25"
    expectReturnTime "2018-04-13 21:21:25"
    returnTime "2018-04-13 21:21:25"
  end
end
