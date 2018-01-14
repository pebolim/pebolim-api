Rails.application.routes.draw do
  post '/login', to: 'authentication#login'
  post '/signin', to: 'authentication#signin'

  #_____________Games_____________
  put '/game/:id/start', to: 'games#startGame'
  put '/game/:id/finish', to: 'games#finishGame'
  put '/game/:id/joinuser', to: 'games#joinUserToGame'
  put '/game/:id/leaveuser', to: 'games#leaveUserFromGame'
  put '/game/:id/jointeam', to: 'games#joinTeamToGame'
  put '/game/:id/leaveteam', to: 'games#leaveTeamFromGame'
  put '/game/:id/remove', to: 'games#removePlayer'
  get '/game/:id/players', to: 'games#getPlayers'
  get '/game/:id/details', to: 'games#gameDetails'
  get '/game/:id/goals', to: 'games#getGoals'
  get '/game/index', to: 'games#index', as: 'casual_games'
  get '/game/public', to: 'games#publicGames'
  post '/game', to: 'games#create'

  #_____________Players_____________
  get '/players', to: 'players#index'
  get '/player/games/:pageid', to: 'players#showGamesByUser'
  get '/player/game/:gameid', to: 'players#showGameByUser'
  get '/player', to: 'players#getProfile'
  get '/player/nPages', to: 'players#getPagesofGamesByUser'

  #----teams----
  get '/teams', to: 'teams#index'
  get '/teams/unavailable', to: 'teams#unavailable'
  get '/teams/pendent', to: 'teams#pendent'
  post '/team/invite', to: 'teams#create'
  put '/team/join/:id', to: 'teams#join'
  put '/team/leave/:id', to: 'teams#leave'
  put '/team/restore/:id', to: 'teams#restore'
end