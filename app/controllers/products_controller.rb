class ProductsController < ApplicationController
  # Railsのコールバック機能で、特定のタイミング(set_product)で
  # show, edit, update, destroyについて、
  # product = Product.find(params[:id])という処理を行なっていく
  before_action :set_product, only: [:show, :edit, :update, :destroy, :favorite]
  def index
    @products = Product.all
  end

  def show
    # 商品に関するすべてのレビューを取得して@reviewsに代入
    @reviews = @product.reviews
    # 新しいレビュー作成？
    @review = @reviews.new
  end

  def new
    @product = Product.new
    @categories = Category.all
  end

  def create
    @product = Product.new(product_params)
    
    @product.save
    redirect_to(product_url(@product))
  end

  def edit
    @categories = Category.all
  end

  def update
    @product.update(product_params)
    redirect_to(product_url(@product))
  end

  def destroy
    @product.destroy
    redirect_to(products_url)
  end

  def favorite
    current_user.toggle_like!(@product) #toggle like
    redirect_to(product_url(@product))
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :description, :price, :category_id)
    end
end
