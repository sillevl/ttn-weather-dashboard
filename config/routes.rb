Rails.application.routes.draw do
  post 'api/weather'

  resources :sensors
  resources :weathers

  root 'sensors#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount ActionCable.server => '/cable'
end
