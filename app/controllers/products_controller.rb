class ProductsController < ApplicationController
  # Railsのコールバック機能で、特定のタイミング(set_product)で
  # show, edit, update, destroyについて、
  # product = Product.find(params[:id])という処理を行なっていく
  before_action :set_product, only: [:show, :edit, :update, :destroy, :favorite]
  
  def index
    #分岐条件を作成
    
    #sort_paramが存在するとき（並び替えをしたとき）
    if sort_params.present?
      #並び替えのカテゴリを@categoryに代入
      @category = Category.request_category(sort_params[:sort_category])
      #並び替えしたときの商品データを返す
      @products = Product.sort_products(sort_params, params[:page])
    #sort_paramは存在しないが、params[:category]が存在するとき（カテゴリを選択したとき）
    elsif params[:category].present?
      #params[:category]のカテゴリを@categoryに代入
      @category = Category.request_category(params[:category])
      #選択したカテゴリに属する商品データを返す
      @products = Product.category_products(@category, params[:page])
    #どちらも存在しないとき（indexページにアクセスしたとき）  
    else
      @products = Product.display_list(params[:page])
    end

    # # display_listメソッドを使って条件によって表示する商品を変更
    # # display_listメソッドは「カテゴリ」と「現在のページ」の2つ引数がいる
    # @products = Product.display_list(category_params, params[:page])
    # @category = Category.request_category(category_params)
    # # すべてのカテゴリを@categoriesに代入、その後カテゴリを代入し、ビューに渡していく
    @categories = Category.all
    # 
    @major_category_names = Category.major_categories
    #
    @sort_list = Product.sort_list
  end

  def show
    # 商品に関するすべてのレビューを取得して@reviewsに代入
    @reviews = @product.reviews_with_id
    # 新しいレビュー作成？
    @review = @reviews.new
    @star_repeat_select = Review.star_repeat_select
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

    def sort_params
      params.permit(:sort, :sort_category)
    end
end
