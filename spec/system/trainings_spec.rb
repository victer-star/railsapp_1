require 'rails_helper'

RSpec.describe "Trainings", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:training) { create(:training, :picture, user: user) }
  let!(:comment) { create(:comment, user_id: user.id, training: training) }

  describe "トレーニング登録ページ" do
    before do
      login_for_system(user)
      visit new_training_path
    end

    context "ページレイアウト" do
      it "「新しいトレーニングの登録」の文字列が存在すること" do
        expect(page).to have_content '新しいトレーニングの登録'
      end

      it "正しいタイトルが表示されること" do
        expect(page).to have_title full_title('新しいトレーニングの登録')
      end

      it "入力部分に適切なラベルが表示されること" do
        expect(page).to have_content 'メニュー名'
        expect(page).to have_content '説明'
        expect(page).to have_content 'コツ・ポイント'
        expect(page).to have_content '参照用URL'
      end
    end

    describe "トレーニング編集ページ" do
      before do
        login_for_system(user)
        visit training_path(training)
        click_link "編集"
      end
  
      context "ページレイアウト" do
        it "正しいタイトルが表示されること" do
          expect(page).to have_title full_title('トレーニング情報の編集')
        end
  
        it "入力部分に適切なラベルが表示されること" do
          expect(page).to have_content 'メニュー名'
          expect(page).to have_content '説明'
          expect(page).to have_content 'コツ・ポイント'
          expect(page).to have_content '参照用URL'
        end
      end
  
      context "トレーニング情報の更新処理" do
        it "有効な更新" do
          fill_in "メニュー名", with: "背筋"
          fill_in "説明", with: "背中の筋肉を鍛えます。"
          fill_in "コツ・ポイント", with: "足をしっかり固定して行いましょう。"
          fill_in "参照用URL", with: "#"
          attach_file "training[picture]", "#{Rails.root}/spec/fixtures/test_training2.jpg"
          click_button "更新する"
          expect(page).to have_content "トレーニング情報が更新されました！"
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

        # context "トレーニングの削除処理", js: true do
        #   it "削除成功のフラッシュが表示されること" do
        #     click_on '削除'
        #     page.driver.browser.switch_to.alert.accept
        #     expect(page).to have_content 'トレーニングが削除されました'
        #   end
        # end
      end
    end

    describe "トレーニング詳細ページ" do
      context "ページレイアウト" do
        before do
          login_for_system(user)
          visit training_path(training)
        end
  
        it "正しいタイトルが表示されること" do
          expect(page).to have_title full_title("#{training.name}")
        end
  
        it "トレーニングが表示されること" do
          expect(page).to have_content training.name
          expect(page).to have_content training.description
          expect(page).to have_content training.tips
          expect(page).to have_content training.reference
          expect(page).to have_link nil, href: training_path(training), class: 'training-picture'
        end
      end
    end

    context "トレーニング登録処理" do
      it "有効な情報でトレーニング登録を行うとトレーニング登録成功のフラッシュが表示されること" do
        fill_in "メニュー名", with: "背筋"
        fill_in "説明", with: "背中の筋肉を鍛えます。"
        fill_in "コツ・ポイント", with: "足をしっかり固定して行いましょう。"
        fill_in "参照用URL", with: "#"
        attach_file "training[picture]", "#{Rails.root}/spec/fixtures/test_training.jpg"
        click_button "登録する"
        expect(page).to have_content "トレーニングが登録されました！"
      end

      it "画像無しで登録すると、デフォルト画像が割り当てられること" do
        fill_in "メニュー名", with: "背筋"
        click_button "登録する"
        expect(page).to have_link(href: training_path(Training.first))
      end

      it "無効な情報でt登録を行うとトレーニング登録失敗のフラッシュが表示されること" do
        fill_in "メニュー名", with: ""
        fill_in "説明", with: "背中の筋肉を鍛えます。"
        fill_in "コツ・ポイント", with: "足をしっかり固定して行いましょう。"
        fill_in "参照用URL", with: "#"
        click_button "登録する"
        expect(page).to have_content "メニュー名を入力してください"
      end
    end

    context "コメントの登録＆削除" do
      it "自分のトレーニングに対するコメントの登録＆削除が正常に完了すること" do
        login_for_system(user)
        visit training_path(training)
        fill_in "comment_content", with: "かなりきついです・・・"
        click_button "コメント"
        within find("#comment-#{Comment.last.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: 'かなりきついです・・・'
        end
        expect(page).to have_content "コメントを追加しました！"
        click_link "削除", href: comment_path(Comment.last)
        expect(page).not_to have_selector 'span', text: 'かなりきついです・・・'
        expect(page).to have_content "コメントを削除しました"
      end

      it "別ユーザーのトレーニングのコメントには削除リンクが無いこと" do
        login_for_system(other_user)
        visit training_path(training)
        within find("#comment-#{comment.id}") do
          expect(page).to have_selector 'span', text: user.name
          expect(page).to have_selector 'span', text: comment.content
          expect(page).not_to have_link '削除', href: training_path(training)
        end
      end
    end
  end

  context "検索機能" do
    context "ログインしている場合" do
      before do
        login_for_system(user)
        visit root_path
      end

      it "ログイン後の各ページに検索窓が表示されていること" do
        expect(page).to have_css 'form#training_search'
        visit about_path
        expect(page).to have_css 'form#training_search'
        visit use_of_terms_path
        expect(page).to have_css 'form#training_search'
        visit users_path
        expect(page).to have_css 'form#training_search'
        visit user_path(user)
        expect(page).to have_css 'form#training_search'
        visit edit_user_path(user)
        expect(page).to have_css 'form#training_search'
        visit following_user_path(user)
        expect(page).to have_css 'form#training_search'
        visit followers_user_path(user)
        expect(page).to have_css 'form#training_search'
        visit trainings_path
        expect(page).to have_css 'form#training_search'
        visit training_path(training)
        expect(page).to have_css 'form#training_search'
        visit new_training_path
        expect(page).to have_css 'form#training_search'
        visit edit_training_path(training)
        expect(page).to have_css 'form#training_search'
      end

      it "フィードの中から検索ワードに該当する結果が表示されること" do
        create(:training, name: '背筋トレーニング', user: user)
        create(:training, name: 'とてもきつい背筋', user: other_user)
        create(:training, name: '腹筋100回だ！', user: user)
        create(:training, name: 'モテモテ腹筋を目指す！', user: other_user)

        # 検索
        fill_in 'q_name_cont', with: '背筋'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”背筋”の検索結果：2件"
        within find('.trainings') do
          expect(page).to have_css 'li', count: 2
        end
        fill_in 'q_name_cont', with: '腹筋'
        click_button '検索'
        expect(page).to have_css 'h3', text: "”腹筋”の検索結果：2件"
        within find('.trainings') do
          expect(page).to have_css 'li', count: 2
        end
      end

      it "検索ワードを入れずに検索ボタンを押した場合、トレーニング一覧が表示されること" do
        fill_in 'q_name_cont', with: ''
        click_button '検索'
        expect(page).to have_css 'h3', text: "トレーニング一覧"
        within find('.trainings') do
          expect(page).to have_css 'li', count: Training.count
        end
      end
    end

    context "ログインしていない場合" do
      it "検索窓が表示されないこと" do
        visit root_path
        expect(page).not_to have_css 'form#training_search'
      end
    end
  end

  describe "筋トレ一覧ページ" do
    context "CSV出力機能" do
      before do
        login_for_system(user)
      end

      it "トップページからCSV出力が行えること" do
        visit root_path
        click_link 'みんなのトレーニングをCSV出力'
        expect(page.response_headers['Content-Disposition']).to \
          include("みんなの筋トレ一覧_#{Time.current.strftime('%Y%m%d_%H%M')}.csv")
      end

      it "プロフィールページからCSV出力が行えること" do
        visit user_path(user)
        click_link 'みんなのトレーニングをCSV出力'
        expect(page.response_headers['Content-Disposition']).to \
          include("みんなの筋トレ一覧_#{Time.current.strftime('%Y%m%d_%H%M')}.csv")
      end
    end
  end
end
