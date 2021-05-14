require 'rails_helper'

RSpec.describe Training, type: :model do
  let!(:training_yesterday) { create(:training, :yesterday) }
  let!(:training_one_week_ago) { create(:training, :one_week_ago) }
  let!(:training_one_month_ago) { create(:training, :one_month_ago) }
  let!(:training) { create(:training) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(training).to be_valid
    end

    it "名前がなければ無効な状態であること" do
      training = build(:training, name: nil)
      training.valid?
      expect(training.errors[:name]).to include("を入力してください")
    end

    it "名前が30文字以内であること" do
      training = build(:training, name: "あ" * 31)
      training.valid?
      expect(training.errors[:name]).to include("は30文字以内で入力してください")
    end

    it "説明が140文字以内であること" do
      training = build(:training, description: "あ" * 141)
      training.valid?
      expect(training.errors[:description]).to include("は140文字以内で入力してください")
    end

    it "コツ・ポイントが50文字以内であること" do
      training = build(:training, tips: "あ" * 51)
      training.valid?
      expect(training.errors[:tips]).to include("は50文字以内で入力してください")
    end

    it "ユーザーIDがなければ無効な状態であること" do
      training = build(:training, user_id: nil)
      training.valid?
      expect(training.errors[:user_id]).to include("を入力してください")
    end
  end

  context "並び順" do
    it "最も最近の投稿が最初の投稿になっていること" do
      expect(training).to eq Training.first
    end
  end
end
