Rails.application.routes.draw do

  get'/posts' , to: 'posts#all_posts' , as: 'all_posts'
  root  to:'main#index'
  resources :topics do
    resources :posts do
      resources :comments
      resources :ratings, only: [:create]
    end
  end
  resources :tags do
    member do
      get 'posts', to: 'tags#posts', as: 'posts'
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
