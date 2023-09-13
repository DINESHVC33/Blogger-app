Rails.application.routes.draw do

  resources :topics do
    resources :posts
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
