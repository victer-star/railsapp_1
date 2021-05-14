require 'rails_helper'

RSpec.describe "Trainings", type: :system do
  let!(:user) { create(:user) }
  let!(:training) { create(:training, :picture, user: user) }

  describe "筋トレメニュー登録ページ" do
    before do
      login_for_system(user)
      visit new_training_path
    end

    context "ページレイアウト" do
      it "「筋トレメニューの登録」の文字列が存在すること" do
        expect(page).to have_content '筋トレメニューの登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('筋トレメニューの登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'メニュー名'
        expect(page).to have_content '説明'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content '参照用URL'
      end
    end

    describe "筋トレメニュー編集ページ" do
      before do
        login_for_system(user)
        visit training_path(training)
        click_link "編集"
      end
  
      context "ページレイアウト" do
        it "正しいタイトルが表示されること" do
          expect(page).to have_title full_title('筋トレメニューの編集')
        end
  
        it "入力部分に適切なラベルが表示されること" do
          expect(page).to have_content 'メニュー名'
          expect(page).to have_content '説明'
          expect(page).to have_content 'コツ・ポイント'
          expect(page).to have_content '参照用URL'
        end
      end
  
      context "筋トレメニューの更新処理" do
        it "有効な更新" do
          fill_in "メニュー名", with: "背筋"
          fill_in "説明", with: "背中の筋肉を鍛えます。"
          fill_in "コツ・ポイント", with: "足をしっかり固定して行いましょう。"
          fill_in "参照用URL", with: "#"
          attach_file "training[picture]", "#{Rails.root}/spec/fixtures/test_training2.jpg"
          click_button "更新する"
          expect(page).to have_content "筋トレメニューが更新されました！"
          expect(training.reload.name).to eq "背筋"
          expect(training.reload.description).to eq "背中の筋肉を鍛えます。"
          expect(training.reload.tips).to eq "足をしっかり固定して行いましょう。"
          expect(training.reload.reference).to eq "#"
          expect(training.reload.picture.url).to include "test_training2.jpg"
        end
  
        it "無効な更新" do
          fill_in "メニュー名", with: ""
          click_button "更新する"
          expect(page).to have_content 'メニュー名を入力してください'
          expect(training.reload.name).not_to eq ""
        end

        # context "筋トレメニューの削除処理", js: true do
        #   it "削除成功のフラッシュが表示されること" do
        #     click_on '削除'
        #     page.driver.browser.switch_to.alert.accept
        #     expect(page).to have_content '筋トレメニューが削除されました'
        #   end
        # end
      end
    end

    describe "筋トレメニュー詳細ページ" do
      context "ページレイアウト" do
        before do
          login_for_system(user)
          visit training_path(training)
        end
  
        it "正しいタイトルが表示されること" do
          expect(page).to have_title full_title("#{training.name}")
        end
  
        it "筋トレメニューが表示されること" do
          expect(page).to have_content training.name
          expect(page).to have_content training.description
          expect(page).to have_content training.tips
          expect(page).to have_content training.reference
          expect(page).to have_link nil, href: training_path(training), class: 'training-picture'
        end
      end
    end

    context "筋トレメニュー登録処理" do
      it "有効な情報でメニュー登録を行うとメニュー登録成功のフラッシュが表示されること" do
        fill_in "メニュー名", with: "背筋"
        fill_in "説明", with: "背中の筋肉を鍛えます。"
        fill_in "コツ・ポイント", with: "足をしっかり固定して行いましょう。"
        fill_in "参照用URL", with: "#"
        attach_file "training[picture]", "#{Rails.root}/spec/fixtures/test_training.jpg"
        click_button "登録する"
        expect(page).to have_content "筋トレメニューが登録されました！"
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "メニュー名", with: "背筋"
        click_button "登録する"
        expect(page).to have_link(href: training_path(Training.first))
      end

      it "無効な情報で料理登録を行うと料理登録失敗のフラッシュが表示されること" do
        fill_in "メニュー名", with: ""
        fill_in "説明", with: "背中の筋肉を鍛えます。"
        fill_in "コツ・ポイント", with: "足をしっかり固定して行いましょう。"
        fill_in "参照用URL", with: "#"
        click_button "登録する"
        expect(page).to have_content "メニュー名を入力してください"
      end
    end
  end
end
