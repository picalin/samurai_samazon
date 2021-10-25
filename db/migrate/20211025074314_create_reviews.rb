class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :content #レビューの内容
      t.references :product, foreign_key: true #product_id, 外部キーをTrue
      t.references :user, foreign_key: true #user_id, 外部キーをTrue

      t.timestamps
    end
  end
end
