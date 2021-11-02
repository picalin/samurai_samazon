class ShoppingCartsController < ApplicationController
  before_action :set_cart, only: %i[index create destroy]
  def index
    #カートに入っているすべての商品データ
    @user_cart_items = ShoppingCartItem.user_cart_items(@user_cart)
  end

  def show
    ユーザーのカートのデータをデータベースから呼び出し、@cartに代入しています。
    @cart = ShoppingCart.find(user_id: current_user)
  end

  def create
    @product = Product.find(product_params[:product_id])
    #以下のコードでaddメソッドを使って送信されたデータをもとにして商品をカートに追加している
    #to_iは文字列を整数に変換するメソッド
    @user_cart.add(@product, product_params[:price].to_i, product_params[:quantity].to_i)
    redirect_to cart_users_path
  end

  def update
  end

  def destroy
    #注文済みフラグをtrueにして、注文処理を行い、
    #その後カーｓトのデータをデータベースに保存してリダイレクト
    @user_cart.buy_flag = true
    @user_cart.save
    redirect_to cart_users_url
  end

  private
  def product_params
    params.permit(:product_id, :price, :quantity)
  end
  def set_cart
    #まだ注文が確定していないカートのデータ
    @user_cart = ShoppingCart.set_user_cart(current_user)
  end
end
