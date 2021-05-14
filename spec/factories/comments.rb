FactoryBot.define do
  factory :comment do
    user_id { 1 }
    content { "少しきつかったので、回数を5回減らす。" }
    association :training
  end
end
