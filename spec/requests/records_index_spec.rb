require 'rails_helper'

RSpec.describe "トレーニング記録", type: :request do
  let!(:user) { create(:user) }

  context "トレーニング記録カレンダーの表示" do
    context "ログインしている場合" do
      it "レスポンスが正常に表示される" do
        login_for_request(user)
        get records_path
        expect(response).to have_http_status "200"
        expect(response).to render_template('records/index')
      end
    end

    context "ログインしていない場合" do
      it "ログイン画面にリダイレクトすること" do
        get records_path
        expect(response).to have_http_status "302"
        expect(response).to redirect_to login_path
      end
    end
  end
end
