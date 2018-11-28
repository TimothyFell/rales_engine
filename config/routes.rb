Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      
      namespace :merchants do
        get '/find_all', to: 'merchant_search#index'
        get '/find', to: 'merchant_search#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :customers do
        get '/find_all', to: 'customer_search#index'
        get '/find', to: 'customer_search#show'
      end
      resources :customers, only: [:index, :show]

    end
  end

end
