PaymillRails::Application.routes.draw do
  get "transactions/index"

  
  root to: 'transactions#index'
  resources :subscriptions
  resources :plans
  
  resources :transactions
    
  match ':controller(/:action(/:id(.:format)))'
end
