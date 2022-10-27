Rails.application.routes.draw do

  namespace :api do
      get 'test_jwt', to: 'test_jwt#index'
      post "/auth", to: "user_token#create"

      api_version(:module => "V1", :path => {:value => "api/v1"}, :default => true) do

        resources :app_users do
          resources :clients, :providers
        end

        resources :providers, :clients, :slots, :reservations,
        :blacklists, :strikes, :establishments, :ratings,
        :slot_blueprints, :manual_slot_blueprints, :periodic_slot_blueprints, :manual_slots

      end

  end

end
