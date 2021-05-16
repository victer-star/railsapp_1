require 'csv'

CSV.generate do |csv|
  # 1行目にラベルを追加
  csv_column_labels = %w(名前 説明 作成者 参照用URL\
                         コツ・ポイント 最初に作った日時)
  csv << csv_column_labels
  # 各筋トレメニューのカラム値を追加
  current_user.feed.each do |training|
    csv_column_values = [
      training.name,
      training.description,
      training.user.name,
      training.reference,
      training.tips,
      training.created_at.strftime("%Y/%m/%d(%a)")
    ]
    # 最終的なcsv_column_valuesをcsvのセルに追加
    csv << csv_column_values
  end
end
