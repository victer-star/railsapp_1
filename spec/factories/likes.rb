FactoryBot.define do
  factory :like do
    association :user
    association :training
  end
end
