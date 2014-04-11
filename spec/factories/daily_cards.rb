# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :daily_card do
    event_date "2014-04-11 11:32:08"
    memo "MyText"
    card_image "MyString"
  end
end
