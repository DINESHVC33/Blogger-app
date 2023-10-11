Rails.application.routes.draw do
  devise_for :users
  #devise_for :users, controllers: { sessions: 'users/sessions' }
  get'/posts' , to: 'posts#all_posts' , as: 'all_posts'
  root  to:'home#index'
  resources :topics do
    resources :posts do
      patch 'mark_as_read', on: :member
      resources :comments do
        post 'rate', on: :member
        get 'ratings', on: :member, as: 'comment_ratings'
      end
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
