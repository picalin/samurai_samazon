class CreateMajorCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :major_categories do |t|
      t.string :name #親カテゴリの名前
      t.text :description #親カテゴリの説明

      t.timestamps
    end
  end
end
