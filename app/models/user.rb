class User < ApplicationRecord
  has_many :reviews # Userはreviewを複数持つ
  extend DisplayList
  extend SwitchFlg

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  acts_as_liker #お気に入りをする側のモデルに追加
  
  # 商品に対して「いいね」をつける。
  # user.like!(product)

  # 商品に対する「いいね」を解除する。
  # user.unlike!(product)

  # 商品に対する「いいね」の状態を現在の状態から逆にする。
  # user.toggle_like!(product)

  # 商品に対して「いいね」をつけていればtrueを返し、つけていなければfalseを返す。
  # user.likes?(product)

  # 「いいね」の数をカウントし、整数を返す。
  # def change
  #   add_column :#{Table_name}, :likees_count, :integer, :default => 0
  # end

  # user.likees_count
  
  #ユーザーから送信されたpasswordとpassword_confirmationが一致するかどうかを確認し、一致する場合のみパスワードを暗号化してデータベースに保存
  def update_passsword(params, *options)
    if params[:password].blank?
      params.delete(:password)
      params.delete(:password_confirmation) if params[:password_confirmation].blank?
    end

    result = update(params, *options)
    clean_up_passwords
    result
  end

  #検索するときのメソッド
  scope :search_information, -> (keyword) {
    where("name LIKE :keyword OR id LIKE :keyword OR email LIKE :keyword OR address LIKE :keyword OR postal_code LIKE :keyword OR phone LIKE :keyword", keyword: "%#{keyword}%")
  }

end
