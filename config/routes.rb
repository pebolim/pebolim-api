Rails.application.routes.draw do
  post '/login', to: 'authentication#login'
  post '/signin', to: 'authentication#signin'

  #_____________Games_____________
  put '/game/:id/start', to: 'games#startGame'
  put '/game/:id/finish', to: 'games#finishGame'
  put '/game/:id/join/:teamid', to: 'games#joinGame'
  put '/game/:id/remove', to: 'games#removePlayer'
  get '/game/:id/players', to: 'games#getPlayers'
  get '/game/:id', to: 'games#gameDetails'
  get '/game/index', to: 'games#index', as: 'casual_games'
  post '/game', to: 'games#create'

  #_____________Players_____________
  get '/players', to: 'players#index'
  get '/player/games', to: 'players#showGamesByUser'
  get '/player/game/:gameid', to: 'players#showGameByUser'
  get '/player', to: 'players#getProfile'

  #----teams----
  get '/teams', to: 'teams#index'
  get '/teams/unavailable', to: 'teams#unavailable'
  get '/teams/pendent', to: 'teams#pendent'
  post '/team/invite', to: 'teams#create'
  put '/team/join/:id', to: 'teams#join'
  put '/team/leave/:id', to: 'teams#leave'
  put '/team/restore/:id', to: 'teams#restore'
end
