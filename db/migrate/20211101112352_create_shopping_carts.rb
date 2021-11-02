class CreateShoppingCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :shopping_carts do |t|
      t.boolean :buy_flag, null: false, default: false #カートが注文確定済みかどうか
      t.references :user, foreign_key: true #ユーザのカートが判別できるように

      t.timestamps
    end
  end
end
