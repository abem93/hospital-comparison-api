Rails.application.routes.draw do
  get 'web/bootstrap'
  scope '/' do
    post 'login', to: 'sessions#create'
  end
  
 
  resources :users
  resources :procedures
  resources :procedure_costs
  resources :insurances
  resources :hospitals
end
