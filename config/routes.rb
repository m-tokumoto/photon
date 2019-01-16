Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :photos, except:[:edit,:update] do
  	resource :likes, only: [:create, :destroy]
  end

  resources :users, only:[:show, :edit, :update] do
    get '/favorites' => 'users#favorite', as: 'favorite_photos'
    get '/articles' => 'users#articles', as: 'articles'
  end

  resources :users do
	member do
	 get :following, :followers
	end
  end

  resources :relationships, only: [:create, :destroy]

  resources :articles


  get '/follow' => 'photos#follow', as: 'follow'
  get '/tagged_photos' => 'photos#tag_show', as: 'tag_show'

  get '/tag_search' => 'photos#tag_search',as: 'tag_search'
  post '/tag_search' => 'photos#tag_search',as: 'tags_search'

  get '/article_search' => 'articles#article_search',as: 'article_search'
  post '/article_search' => 'articles#article_search',as: 'articles_search'

  root 'photos#index'

end
