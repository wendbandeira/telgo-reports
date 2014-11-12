TelgoReports::Application.routes.draw do

  resources :agents

  resources :groups
  resources :queue_logs
  root 'home#index'
end
