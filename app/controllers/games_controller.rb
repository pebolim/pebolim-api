# require 'securerandom'

class GamesController < ApplicationController

    before_action :set_default_response_format
    
    # def index
    #     @games = Game.all
    # end

    def gameDetails
        if @game = Game.find_by(:url => params[:id])  
            @participations = @game.participations    
            @status=200  
        else
            render json: {message:"Game not found", status:500}.to_json
        end
    end

    #TODO: verificar parametros e validar o user
    def startGame     
        game = Game.find_by(:url => params[:id])   
        if game.users.count == 4
            game.state = 2
            game.start_date = DateTime.now
            game.is_locked = true

            if game.save
                render json: { message: "OK", status: 200 }.to_json   
            else
                render json: { message: "Is not possible to start the game, try again later", status: 500 }.to_json
            end
        else
            render json: { message: "Unsufficient players to start the game", status: 500 }.to_json 
        end
    end

    def joinUserToGame
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            game = Game.find_by(:url => params[:id])

            #remover a posição antiga
            game.teams.each do |team|
                if team.users.exists?(@current_user)
                    team.partnerships.where(user_id:@current_user).first.delete
                end
            end
            
            #inserir na nova posição
            if Partnership.where(team_id:params[:teamid]).length < 2
                new_partnership = Partnership.new(user_id:@current_user, team_id:params[:teamid])
                if new_partnership.save
                    render json: {message:"OK", status:200}.to_json
                else
                    render json: {message:"Cannot enter that team", status:500}.to_json
                end
            else
                render json: {message:"That team is complete", status:500}.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    def joinTeamToGame
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            game = Game.find_by(:url => params[:id])
            if game.participations.count<2
                #remover a posição antiga
                if params.has_key?(:teamid)
                    team = Team.find(params[:teamid]);
                    if team.users.exists?(@current_user)
                        participation=Participation.new(
                            team_id:params[:teamid],
                            game_id:game.id 
                        )
                        if participation.save
                            render json: {message:"OK", status:200}.to_json
                        else
                            render json: {message:"Was not possible to add team to game", status:500}.to_json
                        end
                    else
                        render json: {message:"You have no right on that team", status:500}.to_json
                    end
                else
                    render json: {message:"You need to define the team", status:500}.to_json
                end
            else
                render json: {message:"The game is full", status:500}.to_json            
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    def publicGames
        get_user_by_token(request)
        if @status!=500 && @current_user!=0

            player = User.find(@current_user)
            g=Game.where(:is_private=>false).where(:state=>1)
            games=[]
            
            g.each do |game|
                count=0
                game.teams.each do |team|
                    count = count + team.users.length
                end 
                games.push({
                    "url":game["url"],
                    "match_day":game["match_day"],
                    "local":game["local"],
                    "numPlayers":count
                })
            end
            render json: {games:games, status:200, message:"OK"}.to_json
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    def leaveUserFromGame
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            game = Game.find_by(:url => params[:id])

            #remover a posição antiga
            game.teams.each do |team|
                if team.users.exists?(@current_user)
                    team.partnerships.where(user_id:@current_user).first.delete
                end
            end
            render json: {message:"OK", status:200}.to_json
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    def leaveTeamFromGame
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            game = Game.find_by(:url => params[:id])

            #remover a posição antiga
            if params.has_key?(:teamid)
                team = Team.find(params[:teamid]);
                if team.users.exists?(@current_user)
                    game.participations.where(team_id:params[:teamid]).first.delete
                    render json: {message:"OK", status:200}.to_json
                else
                    render json: {message:"You have no right on that team", status:500}.to_json
                end
            else
                render json: {message:"You need to define the team", status:500}.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    #post
    def create
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            if params.has_key?(:local) && params.has_key?(:hour) && params.has_key?(:minutes) && params.has_key?(:start_date)
                date = Date.parse(params[:start_date])
                game = Game.new(
                    local: params[:local],
                    url: SecureRandom.urlsafe_base64,
                    match_day: DateTime.new(date.year, date.month, date.mday, params[:hour], params[:minutes]),
                    owner: User.find(@current_user)
                )
                if params.has_key?(:is_private) && params[:is_private]!=""
                    game.is_private= params[:is_private];
                end
                if params.has_key?(:to_teams) && params[:to_teams]!=""
                    game.to_teams= params[:to_teams];
                    if game.save
                        render json: { message: "OK", status: 201, url_id: game.url }.to_json 
                    else
                        render json: { message: "Cannot create a new game", status: 500 }.to_json
                    end
                else
                    if game.save
                        team_1 = Team.new
                        team_2 = Team.new
                        if team_1.save && team_2.save
                            participation_1=Participation.create(game:game, team:team_1)
                            participation_2=Participation.create(game:game, team:team_2)
                            render json: { message: "OK", status: 201, url_id: game.url }.to_json 
                        else
                            render json: { message: "The game cannot be initialized", status: 500 }.to_json
                        end  
                    else
                        render json: { message: "Cannot create a new game", status: 500 }.to_json
                    end
                end
            else
                render json: {message:"You need to fill all fields", status:500}.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
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

    def game_params
        params.require(:game).permit(:local,:is_private,:hour,:minutes,:start_date,:to_teams)
    end

end
