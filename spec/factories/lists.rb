FactoryBot.define do
  factory :list do
    association :user
    association :training
  end
end
