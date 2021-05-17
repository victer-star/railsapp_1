require "rails_helper"

RSpec.describe "筋トレメニューの登録", type: :request do
  let!(:user) { create(:user) }
  let!(:training) { create(:training, user: user) }
  let(:picture_path) { File.join(Rails.root, 'spec/fixtures/test_training.jpg') }
  let(:picture) { Rack::Test::UploadedFile.new(picture_path) }


  context "ログインしているユーザーの場合" do
    before do
      get new_training_path
      login_for_request(user)
    end

    context "フレンドリーフォワーディング" do
      it "レスポンスが正常に表示されること" do
        expect(response).to redirect_to new_training_url
      end
    end

    it "有効な筋トレメニューで登録できること" do
      expect {
        post trainings_path, params: { training: { name: "背筋",
                                                    description: "背中の筋肉を鍛えます。",
                                                    tips: "足をしっかり固定して行いましょう。",
                                                    reference: "#",
                                                    popularity: 5,
                                                    picture: picture } }
      }.to change(Training, :count).by(1)
      follow_redirect!
      expect(response).to render_template('trainings/show')
    end

    it "無効な筋トレメニューでは登録できないこと" do
      expect {
        post trainings_path, params: { training: { name: "",
                                                    description: "背中の筋肉を鍛えます。",
                                                    tips: "足をしっかり固定して行いましょう。",
                                                    reference: "#",
                                                    popularity: 5,
                                                    picture: picture } }
      }.not_to change(Training, :count)
      expect(response).to render_template('trainings/new')
    end
  end

  context "ログインしていないユーザーの場合" do
    it "ログイン画面にリダイレクトすること" do
      get new_training_path
      expect(response).to have_http_status "302"
      expect(response).to redirect_to login_path
    end
  end
end
