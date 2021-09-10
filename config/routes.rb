Rails.application.routes.draw do


  devise_for :admins,controllers: {
  sessions:      'admins/sessions'
 }


  devise_for :users,controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
 }


  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :update, :show]
    get "searches/search"=>"searches#search"
  end



  scope module: :public do

    root to:'homes#top'

    get 'users/unsubscribe' => 'users#unsubscribe'

    patch 'users/withdraw' => 'users#withdraw'

    resources :users, only: [:edit, :update, :show] do
      member do
        get :favorites
        get :datas
      end
    end

    resources :items, only:[:show, :new, :create, :edit, :update] do
      resources :comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end
      
    resources :purchases, only:[:create, :index, :new] 
    
   
    post 'purchases/confirm' => 'purchases#confirm'
    get 'purchases/complete' => 'purchases#complete'
    

    get "searches/tag_lists"=>"searches#tag_lists"

    get "searches/search_tag"=>"searches#search_tag"

    get "searches/search"=>"searches#search"

  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
