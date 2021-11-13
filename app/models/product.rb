class Product < ApplicationRecord
  belongs_to :category
  has_many :reviews #reviewを複数持っている
  acts_as_likeable #お気に入りをされる側のモデルに追加
  has_one_attached :image #Active Strage用の設定を追加

  # そのユーザーが「いいね」をつけていればtrueを返し、つけていなければfalseを返す。
  # product.liked_by?(user)

  # 「いいね」をつけたユーザーを全て返す。
  # product.likers(User)  #Userはモデル名, userは変数

  # 「いいね」をつけたユーザーの数をカウントし、整数を返す。
  # def change
  #   add_column :#{Table_name}, :likers_count, :integer, :default => 0
  # end

  # product.likers_count

  extend DisplayList
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

  scope :search_for_id_and_name, -> (keyword) {
    where("name LIKE ?", "%#{keyword}%").
    or(where("id LIKE ?", "%#{keyword}%"))
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

  scope :recently_products, -> (number) { order(created_at: "desc").take(number)}
  scope :recommend_products, -> (number) { where(recommended_flag: true).take(number)}
  scope :check_products_carriage_list, -> (product_ids) { where(id: product_ids).pluck(:carriage_flag) }

  def reviews_new
    reviews.new
  end
  
  def reviews_with_id
    reviews.reviews_with_id
  end

end

# Scope文
# 特定のSQL文をメソッド化することができる。
