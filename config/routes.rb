Rails.application.routes.draw do
  root 'pages#home'
  get 'posts' => 'posts#index'
  mount Ckeditor::Engine => '/ckeditor'
  resources :contacts
  get 'about' => 'pages#about' 
  devise_for :users
  resources :categories
  resources :posts do
    #post 'comments', to: 'comments#create'
    resources :comments, only: [:create, :destroy]
    member do
      put "like" => "posts#upvote"
      put "unlike" => "posts#downvote"
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
