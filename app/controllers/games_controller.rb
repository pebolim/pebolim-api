class GamesController < ApplicationController

    before_action :set_default_response_format
    
    def index
        @games = Game.all
    end

    def show
        @game = Game.find(find_by_ID)
        @teams = Team.where('game_id' => @game["id"])
    end

    #post
    def create
        @game = Game.new();

        if @game.save
            redirect_to @game
        else
            
        end
    end

    protected
    def set_default_response_format
      request.format = :json
    end

    private
    def find_by_ID
        params[:id]
    end
end
