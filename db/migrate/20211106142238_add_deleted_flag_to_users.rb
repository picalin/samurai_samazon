class AddDeletedFlagToUsers < ActiveRecord::Migration[5.2]
  def change
    # deleted_flg コラムを追加
    add_column :users, :deleted_flg, :boolean, default: false, null: false
  end
end
