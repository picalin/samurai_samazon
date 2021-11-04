class AddScoreToReviews < ActiveRecord::Migration[5.2]
  def change
    # score絡むを追加。unsigned => trueでマイナスの値は受け取らない
    add_column :reviews, :score, :integer, :unsigned => true, :default => 0
  end
end
