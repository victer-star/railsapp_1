FactoryBot.define do
  factory :favorite do
    association :training
    association :user
  end
end
