Rails.application.routes.draw do
  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :confirmations => 'users/confirmations',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    root :to => "web#index"
    get "signup", :to => "users/registrations#new"
    get "verify", :to => "users/registrations#verify"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end

  # ユーザー情報の編集に使うルーティングを以下の通り設定
  resources :users, only: [:edit, :update] do
    # リソース全体に対するアクションを定義するためcollectionを使用。idを使わない
    collection do
      get "cart", :to => "shopping_carts#index"
      post "cart/create", :to => "shopping_carts#create"
      delete "cart", :to => "shopping_carts#destroy"
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      get "mypage/address/edit", :to => "users#edit_address"
      put "mypage", :to => "users#update"
      get "mypage/edit_password", :to => "users#edit_password"
      put "mypage/password", :to => "users#update_password"
      get "mypage/favorite", :to => "users#favorite"
    end
    
  end
  
  #URLをproducts/[:product_id]/reviewsとしている
  resources :products do
    # 商品のidを含むURL（/products/:id/favorite）が使えるようになり、
    # そのURLにアクセスするとproductsコントローラのfavoriteアクションが呼び出されるようになる
    member do
      get :favorite
    end
    resources :reviews, only: [:create]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
