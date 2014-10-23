TelgoReports::Application.routes.draw do

  resources :queue_logs
  root 'home#index'
end
