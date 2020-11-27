Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: [:index, :create, :update, :destroy, :show]
      resources :users, only: [:create]
      resource :sessions do
        get :authorize
      end
      resource :sessions, only: [:create, :destroy, :authorize]
    end
  end
end
