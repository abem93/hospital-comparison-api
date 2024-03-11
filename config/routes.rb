Rails.application.routes.draw do
 scope '/' do
  post 'login', to: 'sessions#create'
 end
 
 resources :users
 resources :procedures
 resources :procedure_costs
 resources :insurances
 resources :hospitals
end
