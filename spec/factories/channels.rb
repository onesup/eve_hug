# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :channel do
    code "MyString"
    name "MyString"
    sort_order 1
  end
end
