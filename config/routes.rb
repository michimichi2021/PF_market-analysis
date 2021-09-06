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
  end



  scope module: :public do
     
    root to:'homes#top'
    
    get 'users/unsubscribe' => 'users#unsubscribe'
    
    patch 'users/withdraw' => 'users#withdraw'

    resources :users, only: [:edit, :update, :show] 

    resources :items, only:[:show, :new, :create, :edit, :update] 

    resources :purchases, only:[:new, :create, :index, :show] do
     get '/confirm' => 'purchases#confirm'
     get '/complete' => 'purchases#complete'  
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
