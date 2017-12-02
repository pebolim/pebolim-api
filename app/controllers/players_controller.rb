class PlayersController < ApplicationController

    before_action :set_default_response_format
    
    def index
        @players = User.all
    end
    
    def showGamesByUser
        player = User.find(get_user_id)
        teams = []
        @games = []
        player.teams.each do |team|
            g = CasualGame.find_by("team1_id = ? OR team2_id = ?",team["id"],team["id"])
            @games.push(g)
        end
    end

    def showGameByUser
        @game = CasualGame.find(get_game_id)
        @owner = User.find(@game.owner_id)["nickname"]
        @best_atacker = User.find(@game.best_atacker)["nickname"]
        @best_defender = User.find(@game.best_defender)["nickname"]
        @game_state = GameState.find(@game.game_state_id)["name"]
        @team1 = Team.find(@game.team1_id)["name"]
        @team2 = Team.find(@game.team2_id)["name"]
    end

    #post
    def create
        @player = Player.new();

        if @player.save
            redirect_to @player
        else
            
        end
    end

    protected
    def set_default_response_format
      request.format = :json
    end

    private
    def get_user_id
        params[:userid]
    end

    def get_game_id
        params[:gameid]
    end
end
