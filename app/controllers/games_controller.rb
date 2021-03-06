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

        game.state = 2
        game.start_date = DateTime.now

        #valida as equipas
        game.teams.each do |team|
            
            users_teams =[];
            team.users.each do |user|
                users_teams.push(user.teams)
            end

            repeted_teams = users_teams.find_all { |e| users_teams.count(e) > 1 }
            if(repeted_teams.length>1)
                repeted_teams.drop(1).each do |repeted|
                    Participation.where(:game=>game, :team=>repeted).delete
                    Partnership.where(:team=>repeted).delete
                    Team.find(repeted["id"]).delete
                end
                Participation.create(:game=>game, :team=>repeted.first)
            end
        end

        if game.save
            render json: { message: "OK", status: 200 }.to_json   
        else
            render json: { message: "Not OK", status: 500 }.to_json
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

    def finishGame    
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            game = Game.find_by(:url => params[:id])

            user=User.find(@current_user)  
            game.state = 3
            game.finish_date = DateTime.now


            if game.owner.id == @current_user

                if game.save
                    render json: { message: "OK", status: 200, finish_date: game.finish_date }.to_json 
                end
            else          
                render json: { message: "Not OK", status: 500 }.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end


    def getPlayers
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            game = Game.find_by(:url => params[:id])
            teams = game.teams

            result = [];
            teams.each do |team| 
                result.push({
                    "id":team["id"],
                    "name":team["name"],
                    "players":team.users.select(:id, :nickname, :image_url)
                })
            end 
            render json: { message: "OK", status: 200, teams: result }.to_json
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
                owner=User.find(game.owner_id).nickname
                games.push({
                    "url":game["url"],
                    "match_day":game["match_day"],
                    "local":game["local"],
                    "to_teams":game["to_teams"],
                    "numPlayers":game.users.length,
                    "owner":owner
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
                if params.has_key?(:is_private) && params[:is_private]!="" && params[:is_private]!=nil
                    game.is_private= params[:is_private];
                end
                if params.has_key?(:to_teams) && params[:to_teams]!="" && params[:to_teams]!=nil
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

    def getGoals
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            @game = Game.find_by(:url => params[:id])
            @goals=[]
            @game.goals.each do |goal|
                team_id=0
                @game.teams.each do |team|
                    if team.users.exists?(goal.user.id)
                        team_id=team.id
                    end
                end
                @goals.push({
                    "time":goal.time,
                    "player_nickname":goal.user.nickname,
                    "player_id":goal.user.id,
                    "team_id":team_id
                })
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    def insertGoal
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            @game = Game.find_by(:url => params[:id])

            scorer = User.find(params[:user])
            puts @game.owner.inspect
            if scorer != nil && @game.owner.id == @current_user
                
                @goal = Goal.new(time: params[:time], game: @game, user: scorer)
                part=@game.participations[params[:team]]
                part.goals=part.goals+1;
                if @goal.save && part.save
                    render json: { message: "OK", status: 201 }.to_json 
                end
            else
                render json: { message: "NOK", status: 500 }.to_json
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

end
