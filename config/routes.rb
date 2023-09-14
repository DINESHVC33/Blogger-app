Rails.application.routes.draw do

  get'/posts' , to: 'topics#all_posts' , as: 'all_posts'
  root  to:'main#index'
  resources :topics do
    resources :posts do
      resources :comments
    end
  end
  resources :tags
  # Defines the root path route ("/")
  # root "articles#index"
end
