# require 'securerandom'

class GamesController < ApplicationController

    before_action :set_default_response_format
    
    # def index
    #     @games = Game.all
    # end

    def gameDetails
        @game = Game.find_by(:url => params[:id])       
        @participations = @game.participations      
    end

    #TODO: verificar parametros e validar o user
    def startGame     
        game = Game.find_by(:url => params[:id])   

        game.state = 2
        game.start_date = DateTime.now
        game.is_locked = true

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

    def getPlayers
        game = Game.find_by(:url => params[:id])
        teams = game.teams

        result = [];
        teams.each do |team| 
            result.push({
                "id":team["id"],
                "name":team["name"],
                "players":team.users.select(:id, :name).take
            })
        end 

        render json: { message: "OK", status: 200, teams: result }.to_json  
    end

    def joinGame
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            @game = Game.find_by(:url => params[:id])
            user=User.find(@current_user)

            #remover a posição antiga
            @game.teams.each do |team|
                if team.partnerships.exists?(:user=>user)
                    team.partnerships.where(:user=>user).first.delete
                end
            end
            
            #inserir na nova posição
            if Partnership.where(:team_id=>params[:teamid]).length < 2
                new_partnership = Partnership.new(user_id:user["id"], team_id:params[:teamid])
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
        
        # @game.teams.where(:defender => params[:user_id]).update_all(defender: 0)

        # @game.teams.update_all(:name => "x")
        # flag = 0;
        # @game.teams.each do |t|
        #     if t.attacker == Integer(user_id)
        #         t.attacker = 0;
        #         flag = 1;
        #     end
        #     if t.defender == Integer(user_id)
        #         t.defender = 0;
        #         flag = 1;
        #     end

        # end

        # if flag == 1
        #     c.data["balance"] = "100"
        #     c.data_will_change!
        #     c.save
        # end 
        
        #if @game.save
            #render json: { message: "OK", status: 200 }.to_json   
        # else
        #     render json: { message: "Not OK", status: 500 }.to_json
        # end
    end

    #post
    def create
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            date = Date.parse(params[:start_date])
            @game = Game.new(
                local: params[:local],
                is_private: params[:is_private],
                url: SecureRandom.urlsafe_base64,
                match_day: DateTime.new(date.year, date.month, date.mday, params[:hour], params[:minutes]),
                owner: User.find(@current_user)
            )
            if @game.save
                team_1 = Team.new
                team_2 = Team.new
                if team_1.save && team_2.save
                    participation_1=Participation.create(game:@game, team:team_1)
                    participation_2=Participation.create(game:@game, team:team_2)
                    render json: { message: "OK", status: 200, url_id: @game.url }.to_json 
                else
                    render json: { message: "The game cannot be initialized", status: 500 }.to_json
                end  
            else
                render json: { message: "Cannot create a new game", status: 500 }.to_json
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
        params.require(:game).permit(:local,:is_private,:hour,:minutes,:start_date)
    end

    def game_params
        params.permit(:local,:is_private,:hour,:minutes,:start_date)
    end
end
