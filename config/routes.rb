Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts
  resources :users
  resource :sessions, only: [:new, :create, :destroy]
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :create, :update, :destroy, :show]
    end
  end
end
