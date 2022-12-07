Rails.application.routes.draw do

  namespace :api do
      get 'test_jwt', to: 'test_jwt#index'
      post "/auth", to: "user_token#create"

      api_version(:module => "V1", :path => {:value => "api/v1"}, :default => true) do

        # custom routes
        get 'app_user_by_cellphone/:cellphone', :to => 'app_users#app_user_by_cellphone'
        get 'client_by_app_user_id/:app_user_id', :to => 'clients#client_by_app_user_id'
        get 'provider_by_app_user_id/:app_user_id', :to => 'providers#provider_by_app_user_id'
        get 'slot_password_by_id/:slot_id', :to => 'slots#slot_password_by_id'
        get 'establishments_by_provider_id/:provider_id', :to => 'establishments#establishments_by_provider_id'
        get 'periodic_slot_by_blueprint_id/:blueprint_id', :to => 'periodic_slots#periodic_slot_by_blueprint_id'
        get 'manual_slot_by_blueprint_id/:type/:blueprint_id', :to => 'manual_slots#manual_slot_by_blueprint_id'
        get 'concrete_slot_by_blueprint_id/:type/:blueprint_id', :to => 'slots#concrete_slot_by_blueprint_id'
        patch 'change_user_password/:cellphone', :to => 'app_users#change_user_password'
        patch 'change_slot_password/:id', :to => 'slots#change_slot_password'
        patch 'set_preferred_position/:id', :to => 'clients#set_preferred_position'
        post 'reservations', :to => 'reservations#create'
        post 'create_establishments', :to => 'providers#create_establishment'
        post 'delete_reservation_by_ids', :to => 'reservations#delete_reservation_by_ids'
        get 'reservations_by_slot_id/:slot_id', :to => 'reservations#reservations_by_slot_id'

        resources :app_users do
          resources :clients, :providers
        end

        resources :providers, except: [:create]
        resources :clients, except: [:create]
        resources :slots
        resources :reservations
        resources :blacklists
        resources :strikes
        resources :establishments, except: [:create]
        resources :ratings
        resources :slot_blueprints
        resources :manual_slot_blueprints, except: [:create]
        resources :periodic_slot_blueprints, except: [:create]
        resources :manual_slots, except: [:create]
        resources :periodic_slots, except: [:create]

      end

  end

end
