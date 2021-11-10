class AddRecommendedFlagToProducts < ActiveRecord::Migration[5.2]
  def change
    # おすすめの商品用コラムの作成
    add_column :products, :recommended_flag, :boolean, default: false
  end
end
