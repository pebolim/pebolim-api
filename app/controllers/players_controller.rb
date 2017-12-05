class PlayersController < ApplicationController

    before_action :set_default_response_format
    

    def index
        @players = User.all
    end

    def getProfile
        p = get_user_by_token(request)
        @player = User.find(@current_user)
    end
    
    def showGamesByUser
        get_user_by_token(request)

        player = User.find(@current_user)
        @games = []
        @winner = []
        @teams = []
        player.teams.sort_by{|e| e[:id]}.each do |team|
            g = CasualGame.find_by("team1_id = ? OR team2_id = ?",team["id"],team["id"])
            @games.push(g)
            t = []
            t.push(Team.find(g.team1_id)["name"])
            t.push(Team.find(g.team2_id)["name"])
            @teams.push(t)
            if((g.result1 > g.result2) && g.team1_id==team["id"] || (g.result2 > g.result1) && g.team2_id==team["id"])
                @winner.push(true)
            else
                @winner.push(false)
            end

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
