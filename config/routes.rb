TelgoReports::Application.routes.draw do
  get "queue_logs/index"
  get "queue_logs/show"
  root 'home#index'
end
