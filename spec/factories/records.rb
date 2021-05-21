FactoryBot.define do
  factory :record do
    association :user
    menu "MyString"
    set 1
    weight 1
    rep 1
    start_time "2021-05-20 03:40:29"
  end
end
