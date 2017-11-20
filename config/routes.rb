Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/game/index', to: 'games#index'
  get '/game/:id', to: 'games#show'
  post '/game', to: 'games#create'
end
