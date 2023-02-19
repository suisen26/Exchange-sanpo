Rails.application.routes.draw do
  # ユーザー
  # デバイスは登録とログインのみ
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: "public/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "about" => "homes#about"
    resources :users, only: [:index, :show, :edit, :update] do
      member do
        get "confirm_withdraw"
        patch "withdraw"
      end
    end
    resources :posts
  end

  # 管理者
  # デバイスはログインのみ
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do
    get "" => "genres#index"
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :destroy]
    resources :posts, only: [:index, :show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
