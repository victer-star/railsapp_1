require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  let(:user) { FactoryBot.create(:user, email: 'mailer_tester@example.com') }
  
  describe "パスワードリセット" do
    let(:mail) { UserMailer.password_reset(user) }
    let(:mail_body) { mail.body.encoded.split(/\r\n/).map{|i| Base64.decode64(i)}.join }

    it "ヘッダーが正しく表示されること" do
      user.reset_token = User.new_token
      expect(mail.subject).to eq("パスワード再設定メール")
      expect(mail.to).to eq(["mailer_tester@example.com"])
      expect(mail.from).to eq(["noreply@example.com"])
    end

    it "メール文が正しく表示されること" do
      user.reset_token = User.new_token
      expect(mail_body).to match user.reset_token
      expect(mail_body).to match CGI.escape(user.email)
    end
  end

end
