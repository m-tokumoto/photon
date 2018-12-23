Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :photos, except:[:edit,:update] do
  	resource :likes, only: [:create, :destroy]
  end
  
  resources :users, only:[:show, :edit, :update] do
  	resources :favorites, only:[:index]
    get '/favorite' => 'users#favorite', as: 'favorite_photos'
  end

  resources :users do
	member do
	 get :following, :followers
	end
  end

  resources :relationships, only: [:create, :destroy]

  resources :articles, only:[:new, :create, :show]


  get '/follow' => 'photos#follow', as: 'follow'
  get '/tagged_photos' => 'photos#tag_show', as: 'tag_show'

  get '/' => 'photos#index' ,as: 'root'

end
