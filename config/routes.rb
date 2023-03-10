Rails.application.routes.draw do
# ユーザー側のルーティング
  # デバイスは登録とログインのみ
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions",
  }

  scope module: :public do
    root to: "homes#top"
    post "users/guest_sign_in", to: "users#guest_sign_in"
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get "favorites"
        get "confirm_withdraw"
        patch "withdraw"
      end
      resource :relationships, only: [:create, :destroy]
      get "followings", to: "relationships#followings", as: "followings"
      get "followers", to: "relationships#followers", as: "followers"
    end
    resources :posts do
      resource :favorites, only: [:create, :destroy]
      resources :post_comments, only: [:create, :destroy]
    end
    get "search", to: "searches#search"
  end

# 管理者側のルーティング
  # デバイスはログインのみ
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "" => "posts#index"
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :destroy] do
      member do
        get "favorites"
        get "confirm_withdraw"
        patch "withdraw"
      end
      get "followings", to: "relationships#followings", as: "followings"
      get "followers", to: "relationships#followers", as: "followers"
    end
    resources :posts, only: [:index, :show, :destroy] do
      resources :post_comments, only: [:destroy]
    end
    get "search", to: "searches#search"
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
