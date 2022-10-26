Rails.application.routes.draw do
  resources :strikes
  resources :blacklists
  resources :reservations

  namespace :api do
      get 'test_jwt', to: 'test_jwt#index'
      post "/auth", to: "user_token#create"

      api_version(:module => "V1", :path => {:value => "api/v1"}, :default => true) do

        resources :app_users do
          resources :clients, :providers
        end

        resources :providers, :clients, :slots, :reservations, :blacklists, :strikes

      end

  end

end
