require 'rails_helper'

RSpec.describe Record, type: :model do
  let!(:record) { create(:record) }

  context "バリデーション" do
    it "有効な状態であること" do
      expect(record).to be_valid
    end

    it "トレーニング名がなければ無効な状態であること" do
      record = build(:record, menu: nil)
      record.valid?
      expect(record.errors[:menu]).to include("を入力してください")
    end
  end
end
