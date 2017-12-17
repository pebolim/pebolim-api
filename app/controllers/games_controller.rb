# require 'securerandom'

class GamesController < ApplicationController

    before_action :set_default_response_format
    
    # def index
    #     @games = Game.all
    # end

    def gameDetails
        @game = CasualGame.find_by(:url => params[:id])       
        @teams = Team.where("id = ? OR id = ?", @game.team1_id, @game.team2_id)      
    end


    #TODO: verificar parametros e validar o user
    def startGame     
        @game = CasualGame.find_by(:url => params[:id])   

        @game.game_state = GameState.find(2)
        @game.start_date = DateTime.now
        @game.is_locked = true

        if @game.save
            render json: { message: "OK", status: 200 }.to_json   
        else
            render json: { message: "Not OK", status: 500 }.to_json
        end
    end

    def getPlayers
        @game = CasualGame.find_by(:url => params[:id])

        @players = User.all().where(id: @game.players)

        result = [];
        @game.players.each.with_index do |value, index| 
            if(value != nil)
                result << @players.where(:id => value)[0]
            else  
                result << nil;
            end
        end 

        if @game.save
            render json: { message: "OK", status: 200, players: result }.to_json   
         else
            render json: { message: "Not OK", status: 500 }.to_json
         end
    end

    def joinGame
        @game = CasualGame.find_by(:url => params[:id])
    
        #remover a posição antiga
        Team.where(id: [@game.team1, @game.team2]).each do |t|
            if t.attacker == Integer(params[:user_id])
                t.update_attribute(:attacker, nil)
            end
            if t.defender == Integer(params[:user_id])
                t.update_attribute(:defender, nil)
            end
        end       
        
        #inserir na nova posição
        if params[:position] == 0 
            @game.team1.update_attribute(:attacker, Integer(params[:user_id]))
        elsif params[:position] == 1
            @game.team1.update_attribute(:defender, Integer(params[:user_id]))
        elsif params[:position] == 2
            @game.team2.update_attribute(:attacker, Integer(params[:user_id]))
        elsif params[:position] == 3
            @game.team2.update_attribute(:defender, Integer(params[:user_id]))
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

        render json: { message: "OK", status: 200 }.to_json   
        
        #if @game.save
            #render json: { message: "OK", status: 200 }.to_json   
        # else
        #     render json: { message: "Not OK", status: 500 }.to_json
        # end
    end

    #post
    def create
        @params = game_params
        @game = CasualGame.new

        @game.local = @params[:local]
        @game.is_private = @params[:is_private]
        @game.url = SecureRandom.urlsafe_base64
        date = Date.parse(@params[:start_date])
        @game.match_day = DateTime.new(date.year, date.month, date.mday, @params[:hour], @params[:minutes])
        @game.game_state = GameState.find(1)
        @game.owner = User.find(1)
        @game.is_locked = false

        #logger.info(@game.inspect) # redirect_to casual_games_path @game
        @game.team1 = Team.new
        @game.team2 = Team.new

        if @game.save
            render json: { message: "OK", status: 201, url_id: @game.url }.to_json   
        else
            render json: { message: "Not OK", status: 500 }.to_json
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
