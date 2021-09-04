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
    resources :genres, only: [:index, :create, :edit, :update]
    resources :users, only: [:index, :show, :edit, :update]
  end



  scope module: :public do
     
    root to:'homes#top'

    resource :users, only: [:edit, :update] do
     get '/my_page' => 'users#show'
     get '/unsubscribe' => 'users#unsubscribe'
     get '/withdraw' => 'users#withdraw'
    end

    resources :items, only:[:show, :new, :create, :edit, :update] 

    resources :purchases, only:[:new, :create, :index, :show] do
     get '/confirm' => 'purchases#confirm'
     get '/complete' => 'purchases#complete'  
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


end
