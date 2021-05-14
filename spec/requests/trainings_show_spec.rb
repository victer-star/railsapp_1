require "rails_helper"

RSpec.describe "筋トレメニュー個別ページ", type: :request do
  let!(:user) { create(:user) }
  let!(:training) { create(:training, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること" do
      login_for_request(user)
      get training_path(training)
      expect(response).to have_http_status "200"
      expect(response).to render_template('trainings/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get training_path(training)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
