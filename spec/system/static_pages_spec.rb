require 'rails_helper'

RSpec.describe "StaticPages", type: :system do
  describe "トップページ" do
    context "ページ全体" do
      before do
        visit root_path
      end

      it "マッスルキングの文字列が存在することを確認" do
        expect(page).to have_content 'マッスルキング'
      end

      it "正しいタイトルが表示されることを確認" do
        expect(page).to have_title full_title
      end

      # context "筋トレメニューフィード", js: true do
      #   let!(:user) { create(:user) }
      #   let!(:new_post) { create(:post, user: user) }
          # before do
          #   login_for_system(user)
          # end

      #   it "料理のぺージネーションが表示されること" do
      #     login_for_system(user)
      #     create_list(:post, 6, user: user)
      #     visit root_path
      #     expect(page).to have_content "筋トレメニュー (#{user.postes.count})"
      #     expect(page).to have_css "div.pagination"
      #     Post.take(5).each do |d|
      #       expect(page).to have_link d.name
      #     end
      #   end

          # it "「新しい料理を作る」リンクが表示されること" do
          #   visit root_path
          #   expect(page).to have_link "新しい料理を作る", href: new_dish_path
          # end

          # it "料理を削除後、削除成功のフラッシュが表示されること" do
          #   visit root_path
          #   click_on '削除'
          #   page.driver.browser.switch_to.alert.accept
          #   expect(page).to have_content '料理が削除されました'
          # end
      # end
    end
  end

  describe "ヘルプページ" do
    before do
      visit about_path
    end

    it "マッスルキングとは？の文字列が存在することを確認" do
      expect(page).to have_content 'マッスルキングとは？'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('マッスルキングとは？')
    end
  end

  describe "利用規約ページ" do
    before do
      visit use_of_terms_path
    end

    it "利用規約の文字列が存在することを確認" do
      expect(page).to have_content '利用規約'
    end

    it "正しいタイトルが表示されることを確認" do
      expect(page).to have_title full_title('利用規約')
    end
  end
end
