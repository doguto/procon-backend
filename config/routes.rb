Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api do
    namespace :v1 do
      resources :posts, only: [:create, :index, :show] do
        collection do
          get "user/:user_id", action: :user_posts
        end
      end
      resources :users, only: [:create, :show] do
        member do
          post :follow
          delete :unfollow
          get :followers
          get :following
        end
      end
    end
  end

  # Defines the root path route ("/")
  # root "posts#index"
end
