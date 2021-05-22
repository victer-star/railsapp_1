require 'rails_helper'

RSpec.describe "いいね機能", type: :request do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  let(:training) { create(:training, user: other_user) }

  context "いいねランキングページの表示" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示されること" do
        login_for_request(user)
        get likes_path
        expect(response).to have_http_status "200"
        expect(response).to render_template('likes/index')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get likes_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end

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

      it "筋トレAjaxによるいいねする/はずすができること" do
        expect {
          post "/likes/#{training.id}/create", xhr: true
        }.to change(user.likes, :count).by(1)
        expect {
          delete "/likes/#{Like.first.id}/destroy", xhr: true
        }.to change(user.likes, :count).by(-1)
      end
    end

    context "ログインしていない場合" do
      it "いいねはできず、ログインページへリダイレクトされる" do
        expect {
          post "/likes/#{training.id}/create"
        }.not_to change(Like, :count)
        expect(response).to redirect_to login_path
      end

      it "いいねをはずすことはできず、ログインページへリダイレクトされる" do
        expect {
          delete "/likes/#{training.id}/destroy"
        }.not_to change(Like, :count)
        expect(response).to redirect_to login_path
      end
    end
  end
end
