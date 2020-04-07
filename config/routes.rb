Rails.application.routes.draw do
  devise_for :users
  root 'home#top'
  get 'home/about'
  get '/search' => 'search#search'
   resources :users do
    member do
      get :following, :followers
    end
  end

  resources :books,only: [:new, :create, :index, :show, :destroy,:edit,:update] do
  resource :favorites, only:[:new,:create,:destroy]
  resource :book_comments, only:[:create, :destroy]
  end	
  resources :users,only: [:show,:index,:edit,:update] 
  resources :relationships, only: [:create, :destroy]
end