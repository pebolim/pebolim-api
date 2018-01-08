class PlayersController < ApplicationController

    before_action :set_default_response_format
    

    def index
        @players = User.all
    end

    def getProfile
        get_user_by_token(request)
        @player = User.find(@current_user)
    end

    def getPagesofGamesByUser
        get_user_by_token(request)
        player = User.find(@current_user)
        @nPages = (Float(player.games.length)/5).ceil
    end
    
    def showGamesByUser
        get_user_by_token(request)

        page = Integer(params[:pageid])-1
        if @status!=500 && @current_user!=0

            player = User.find(@current_user)
            @games=[]
            g = player.games.sort_by{|e| e[:id]}
            g[page*5..page*5+4].each do |game|
                is_winner=false
                teams=[]
                game.participations.each do |participation|
                    if participation.team.users.exists?(@current_user) && participation["is_winner"]
                        is_winner=true;
                    end
                    teams.push({
                        "id":participation.team["id"],
                        "name":participation.team["name"],
                        "goals":participation["goals"]
                    });
                end
                    @games.push({
                        "id":game["id"],
                        "url":game["url"],
                        "match_day":game["match_day"],
                        "local":game["local"],
                        "is_winner":is_winner,
                        "teams":teams
                    })
            end
            @message="OK"
            @status=200
        else
            @message="Unauthorized"
            @status=500
        end
        
    end
=begin
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
=end

    protected
    def set_default_response_format
      request.format = :json
    end

end
