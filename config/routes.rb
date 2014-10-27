TelgoReports::Application.routes.draw do

  resources :groups
  resources :queue_logs
  root 'home#index'
end
