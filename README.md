# アプリケーションの概要
　自分がおすすめする筋トレを登録して共有できる筋トレ投稿サービス。　　　<https://muscle-king-app.herokuapp.com/>


# 期間
  1ヶ月半


# 使用した技術
・テストはRSpecで記述。
・Ajaxを用いていいね、フォロー、お気に入りの切り替えが簡単にできるように。
・Dockerを使い,開発・テスト環境構築
・Bootstrapを使用し、見た目をきれいに


# このアプリの機能
・ユーザーがおすすめする筋トレを投稿
・自分のまたは他のユーザーが投稿したトレーニングを「マイ筋トレリスト」に入れることができる
・トレーニングに対するコメント機能
・フォロー機能
・通知機能
・いいね機能（ランキング付き）
・カレンダー機能(simple_calendar)
・お気に入り機能
・CSV出力
・ログイン機能（ログイン状態を保持する機能）
・メーラー機能(パスワード再設定)
・検索機能(ransack)


# 環境
□フレームワーク
  Ruby on Rails
□データベース
  PostgreSQL


# 苦戦したところ、つまづいたところ
・DockerにChromeを入れることはできたが、なぜかjavascriptを使った操作一部のシステムスペックテストができていないこと。（M1チップのMacを使用しているため、アーキテクチャが違うから？）
・CircleCIを使用してHerokuに自動テスト、デプロイをしようとしたが、データベースがcreateできないエラーが毎回発生し、現在は使用していない。
・メーラー機能を実装するとき。


# これから何を学んでいきたいか
・RSpecをもっと使いこなせるようになりたいため、「Everyday Rails - RSpecによるRailsテスト入門」を読み進めていきながら、テストを描く練習をする。
・AWSにDockerをデプロイできるようにするために学習する。
・rubyを極める！


# 参考にした書籍や記事
・Ruby on Rails5　速習実践ガイド
・プロを目指すためのRuby入門
・使えるRSpec入門(qiita　伊藤淳一さん)
・ポートフォリオ作為のロードマップ（note こうだいさん）


# このアプリを完成し終わった感想
　初めてのアプリ作成で、いろいろなエラーと出会い大変でしたが、なんとか完成させることができて満足しています。
　いくらコードを書き直してもエラーが治らない壁を、やっとぶち破ったときの嬉しさとか、どういう機能を追加すればユーザーにとって使いやすいアプリになるのか考えているときのワクワク？がこのアプリを作っていて感じました。
