Rails.application.routes.draw do

  namespace :api do
      get 'test_jwt', to: 'test_jwt#index'
      post "/auth", to: "user_token#create"

      api_version(:module => "V1", :path => {:value => "api/v1"}, :default => true) do

        # custom routes
        get 'app_user_by_cellphone/:cellphone', :to => 'app_users#app_user_by_cellphone'
        get 'client_by_app_user_id/:app_user_id', :to => 'clients#client_by_app_user_id'
        patch 'change_user_password/:cellphone', :to => 'app_users#change_user_password'
        patch 'change_slot_password/:id', :to => 'slots#change_slot_password'
        post 'reservations', :to => 'reservations#create'
        post 'delete_reservation_by_ids', :to => 'reservations#delete_reservation_by_ids'

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
