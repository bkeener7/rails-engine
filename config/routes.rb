Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, only: [:index, :show]
      resources :items, only: [:index, :show, :create, :destroy]
    end
  end

  get '/api/v1/merchants/:id/items', to: 'api/v1/merchant_items#index', as: :merchant_items
end
