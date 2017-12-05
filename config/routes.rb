Rails.application.routes.draw do
  post '/login', to: 'authentication#login'
  post '/signin', to: 'authentication#signin'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  put '/game/join/:id', to: 'games#joinGame'
  get '/game/index', to: 'games#index', as: 'casual_games'
  get '/game/:id/players', to: 'games#getPlayers'
  get '/game/:id', to: 'games#show'
  post '/game', to: 'games#create'

  #----players----
  get '/players', to: 'players#index'
  get '/player/games', to: 'players#showGamesByUser'
  get '/player/game/:gameid', to: 'players#showGameByUser'
  get '/player', to: 'players#getProfile'
end
