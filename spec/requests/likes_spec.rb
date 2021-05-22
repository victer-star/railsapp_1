require 'rails_helper'

RSpec.describe "いいね機能", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:training) { create(:training, user: other_user) }

  context "いいねする/はずす機能" do
    context "ログインしている場合" do
      before do
        login_for_request(user)
      end

      it "いいねする/はずすができること" do
        expect {
          post "/likes/#{training.id}/create"
        }.to change(user.likes, :count).by(1)
        expect {
          delete "/likes/#{Like.first.id}/destroy"
        }.to change(user.likes, :count).by(-1)
      end
    end
  end
end
