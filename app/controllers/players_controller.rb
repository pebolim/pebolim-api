class PlayersController < ApplicationController

    before_action :set_default_response_format
    
    def index
        @players = Player.all
    end
    
    def showGamesByUser
        player = Player.find(get_user_id)
        @teams = []
        @games = []
        player.teams.each do |team|
            team.games.each do |game|
                g = Game.find(game["id"])
                @games.push(g)
            end
        end
    end

    def showGameByUser
        team = PlayerTeam.find(get_user_id)
        @games = Game.all
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
