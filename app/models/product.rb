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

  scope :display_list, -> (category, page) {
    if category != "none"
      where(category_id: category).page(page).per(PER)
    else
      page(page).per(PER)
    end
  }

  def reviews_new
    reviews.new
  end
end
