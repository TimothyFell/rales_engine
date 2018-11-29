Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      namespace :merchants do
        get '/find_all', to: 'merchant_search#index'
        get '/find', to: 'merchant_search#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :customers do
        get '/:id/favorite_merchant', to: 'customers_fav_merch#show'
        get '/find_all', to: 'customer_search#index'
        get '/find', to: 'customer_search#show'
      end
      resources :customers, only: [:index, :show]

      namespace :items do
        get '/:id/best_day', to: 'items_best_day#show'
        get '/find_all', to: 'item_search#index'
        get '/find', to: 'item_search#show'
      end
      resources :items, only: [:index, :show]

    end
  end

end
