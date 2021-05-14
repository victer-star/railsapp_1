require "rails_helper"

RSpec.describe "筋トレメニュー編集", type: :request do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:training) { create(:training, user: user) }

  context "認可されたユーザーの場合" do
    it "レスポンスが正常に表示されること(+フレンドリーフォワーディング)" do
      get edit_training_path(training)
      login_for_request(user)
      expect(response).to redirect_to edit_training_url(training)
      patch training_path(training), params: { training: { name: "背筋",
                                                            description: "背中の筋肉を鍛えます。",
                                                            tips: "足をしっかり固定して行いましょう。",
                                                            reference: "#" } }
      redirect_to training
      follow_redirect!
      expect(response).to render_template('trainings/show')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      # 編集
      get edit_training_path(training)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
      # 更新
     patch training_path(training), params: { training: { name: "背筋",
                                                          description: "背中の筋肉を鍛えます。",
                                                          tips: "足をしっかり固定して行いましょう。",
                                                          reference: "#" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end

  context "別アカウントのユーザーの場合" do
    it "ホーム画面にリダイレクトすること" do
      # 編集
      login_for_request(other_user)
      get edit_training_path(training)
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
      # 更新
      patch training_path(training), params: { training: { name: "背筋",
                                                            description: "背中の筋肉を鍛えます。",
                                                            tips: "足をしっかり固定して行いましょう。",
                                                            reference: "#" } }
      expect(response).to have_http_status "302"
      expect(response).to redirect_to root_path
    end
  end
end