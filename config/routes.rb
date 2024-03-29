Rails.application.routes.draw do
  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
  }

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    passwords: 'users/passwords',
    registrations: 'users/registrations',
  }

  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :update, :show]
    get "searches/search" => "searches#search"
  end

  scope module: :public do
    get   '/inquiries' => 'inquiries#index'     # 入力画面
    post  'inquiries/confirm' => 'inquiries#confirm'   # 確認画面
    post  'inquiries/thanks'  => 'inquiries#thanks'    # 送信完了画面

    root to: 'homes#top'

    get 'users/unsubscribe' => 'users#unsubscribe'

    patch 'users/withdraw' => 'users#withdraw'

    resources :users, only: [:edit, :update, :show] do
      member do
        get :favorites
        get :datas
        get 'follows'
        get 'followers'
      end

      resource :relationships, only: [:create, :destroy]
    end

    resources :items, only: [:show, :new, :create, :edit, :update, :destroy] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :notifications, only: :index do
      collection do
        delete 'destroy_all'
      end
    end

    resources :purchases, only: [:create, :index, :new]

    post 'purchases/confirm' => 'purchases#confirm'
    get 'purchases/complete' => 'purchases#complete'

    get "searches/tag_lists" => "searches#tag_lists"

    get "searches/search_tag" => "searches#search_tag"

    get "searches/search" => "searches#search"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
