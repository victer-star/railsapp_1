require 'rails_helper'

RSpec.describe "PasswordResets", type: :request do
  let(:user) { FactoryBot.create(:user) }

  before do
    ActionMailer::Base.deliveries.clear
    user.create_reset_digest
  end

  describe "newメソッド" do
    it "正常にページが表示されるか確認" do
      get "/password_resets/new"
      aggregate_failures do
        expect(response).to have_http_status(:success)
        expect(response.body).to include 'パスワード再設定メール'
      end
    end
  end

  describe "createメソッド" do
    it 'メールアドレスが無効' do
      post password_resets_path, params: { password_reset: { email: "" } }
      aggregate_failures do
        expect(response).to have_http_status(200)
        expect(response.body).to include 'パスワード再設定メール'
      end
    end

    it 'メールアドレスが有効' do
      post password_resets_path, params: { password_reset: { email: user.email } }
      aggregate_failures do
        expect(user.reset_digest).not_to eq user.reload.reset_digest
        expect(ActionMailer::Base.deliveries.size).to eq 1
        expect(response).to redirect_to root_url
      end
    end
  end

  describe "def edit" do
    context 'メールアドレスとトークンが有効' do
      before { get edit_password_reset_path(user.reset_token, email: user.email) }

      it '成功していることを確認' do
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to include "パスワード再設定"
        end
      end
    end
  end

  describe "updateメソッド" do
    context "無効なパスワードとパスワード確認" do
      before do
        patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: {
                  password: "foobaz",
                  password_confirmation: "barquux",
                },
              }
      end

      it '失敗することを確認' do
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to include "パスワード再設定"
        end
      end
    end

    context "パスワードが空" do
      before do
        patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: {
                  password: "",
                  password_confirmation: "",
                },
              }
      end

      it '失敗することを確認' do
        aggregate_failures do
          expect(response).to have_http_status(200)
          expect(response.body).to include "パスワード再設定"
        end
      end
    end

    context "有効なパスワードとパスワード確認" do
      before do
        patch password_reset_path(user.reset_token),
              params: {
                email: user.email,
                user: {
                  password: "foobaz",
                  password_confirmation: "foobaz",
                },
              }
      end

      it '成功することを確認' do
        aggregate_failures do
          expect(is_logged_in?).to be_truthy
          expect(response).to redirect_to user
        end
      end
    end
  end
end
