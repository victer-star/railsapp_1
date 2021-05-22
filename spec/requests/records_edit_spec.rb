require 'rails_helper'

RSpec.describe "トレーニング記録の編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:record) { create(:record, user: user)}

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示される" do
      get edit_record_path(record)
      login_for_request(user)
      expect(response).to redirect_to edit_record_url(record)
      patch record_path(record), params: { record: { menu: "背筋",
                                                      set: 1,
                                                    　weight: 20,
                                                      rep: 2,
                                                      start_time: "002021-05-20" } }
      redirect_to record
      follow_redirect!
      expect(response).to render_template('records/index')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にレダイレクトすること" do
      get edit_record_path(record)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      patch record_path(record), params: { records: { menu: "背筋",
                                                      set: 1,
                                                    　weight: 20,
                                                      rep: 2,
                                                      start_time: "002021-05-20" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "トレーニング記録画面にリダイレクトすること" do
      login_for_request(other_user)
      get edit_record_path(record)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to records_path
      patch record_path(record), params: { records: { menu: "背筋",
                                                      set: 1,
                                                    　weight: 20,
                                                      rep: 2,
                                                      start_time: "002021-05-20" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to records_path
    end
  end
end