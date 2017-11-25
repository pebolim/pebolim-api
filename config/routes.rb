Rails.application.routes.draw do
  get 'authentication/register'

  get 'authentication/signin'

  get 'authentication/login'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/game/index', to: 'games#index'
  get '/game/:id', to: 'games#show'
  post '/game', to: 'games#create'

  #----players----
  get '/users', to: 'players#index'
  get '/user/:userid/games', to: 'players#showGames'
  get '/user/:userid/game/:gameid', to: 'players#showGameByUser'
end
