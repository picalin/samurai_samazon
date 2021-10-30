class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews #reviewを複数持っている
  acts_as_likeable #お気に入りをされる側のモデルに追加

  # そのユーザーが「いいね」をつけていればtrueを返し、つけていなければfalseを返す。
  # product.liked_by?(user)

  # 「いいね」をつけたユーザーを全て返す。
  # product.likers(User)  #Userはモデル名, userは変数

  # 「いいね」をつけたユーザーの数をカウントし、整数を返す。
  # def change
  #   add_column :#{Table_name}, :likers_count, :integer, :default => 0
  # end

  # product.likers_count

  PER = 15

  scope :display_list, -> (page) { page(page).per(PER) }
  # scope :category_products, -> (category, page) {
  #   where(category_id: category).page(page).per(PER)
  # }
  # # sort_productsでproductsテーブルのpriceまたはupdated_atの値を使って
  # # 商品を昇順・降順で並び替えできる
  # scope :sort_products, -> (sort_order, page) {
  #   where(category_id: sort_order[:sort_category]).order(sort_order[:sort]).
  #   page(page).per(PER)
  # }

  #リファクタリングのため、コードをシンプル化
  scope :on_category, -> (category) { where(category_id: category) }
  scope :sort_order, -> (order) { order(order) }

  scope :category_products, -> (category, page) { 
    on_category(category).
    display_list(page)
  }

  scope :sort_products, -> (sort_order, page) {
    on_category(sort_order[:sort_category]).
    sort_order(sort_order[:sort]).
    display_list(page)
  }

  scope :sort_list, -> {
    {
      "並び替え" => "",
      "価格の安い順" => "price asc",
      "価格の高い順" => "price desc",
      "出品の古い順" => "updated_at asc",
      "出品の新しい順" => "updated_at desc"
      
    }
  }

  def reviews_new
    reviews.new
  end
end
