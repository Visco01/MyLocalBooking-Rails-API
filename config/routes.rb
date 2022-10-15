Rails.application.routes.draw do
  get 'test_jwt', to: 'test_jwt#index'
  post "/auth", to: "user_token#create"
end
