Rails.application.routes.draw do

  namespace :api do
      get 'test_jwt', to: 'test_jwt#index'
      post "/auth", to: "user_token#create"

      api_version(:module => "V1", :path => {:value => "api/v1"}, :default => true) do

        resources :app_users do
          resources :clients, :providers
        end

        resources :providers, except: [:create]
        resources :clients, except: [:create]
        resources :slots
        resources :reservations
        resources :blacklists
        resources :strikes
        resources :establishments
        resources :ratings
        resources :slot_blueprints
        resources :manual_slot_blueprints, except: [:create]
        resources :periodic_slot_blueprints, except: [:create]
        resources :manual_slots, except: [:create]
        resources :periodic_slots, except: [:create]

      end

  end

end
