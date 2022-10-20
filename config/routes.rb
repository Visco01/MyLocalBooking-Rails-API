Rails.application.routes.draw do

  namespace :api do
      get 'test_jwt', to: 'test_jwt#index'
      post "/auth", to: "user_token#create"

      api_version(:module => "V1", :path => {:value => "api/v1"}, :default => true) do

        resources :app_users do
          resources :clients, :providers
        end

        resources :providers, :clients
      end

  end

end
