Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :users, only: %i(create)
  end
end
