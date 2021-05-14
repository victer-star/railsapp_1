FactoryBot.define do
  factory :training do
    name { "プッシュアップ（腕立て伏せ）" }
    description { "胸や二の腕、背中のトレーニング種目です。" }
    tips { "辛いと感じる方は、膝を床につけて行ってみてください。" }
    reference { "#" }
    association :user
    created_at { Time.current }
  end

  trait :yesterday do
    created_at { 1.day.ago }
  end

  trait :one_week_ago do
    created_at { 1.week.ago }
  end

  trait :one_month_ago do
    created_at { 1.month.ago }
  end

  trait :picture do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_training.jpg')) }
  end
end
