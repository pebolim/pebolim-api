class TeamsController < ApplicationController
    before_action :set_default_response_format
    
    #get
    def index
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            player = User.find(@current_user)
            @teams=[];
            available_partnerships=player.partnerships.where(:state=>3)
            available_partnerships.each do |partnership|
                team=Team.find(partnership.team_id)
                partner=team.users.where.not(:id=>@current_user).first
                @teams.push({
                    "id": team["id"],
                    "is_official": team["is_official"],
                    "name": team["is_official"]? team["name"]: nil,
                    "image_url": team["is_official"] ? team["image_url"] : nil,
                    "partner":{
                        "id":partner["id"],
                        "nickname":partner["nickname"],
                        "image_url":partner["image_url"]
                    }
                })
                @status=200;
            end
        end
    end

    #get
    def pendent
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            player = User.find(@current_user)
            @teams=[];
            pendent_partnerships=player.partnerships.where(:state=>2)
            pendent_partnerships.each do |partnership|
                team=Team.find(partnership.team_id)
                partner=team.users.where.not(:id=>@current_user).first
                @teams.push({
                    "id": team["id"],
                    "is_official": team["is_official"],
                    "name": team["is_official"]? team["name"]: nil,
                    "image_url": team["is_official"] ? team["image_url"] : nil,
                    "partner":{
                        "id":partner["id"],
                        "nickname":partner["nickname"],
                        "image_url":partner["image_url"]
                    }
                })
                @status=200;
            end
        end
    end

    #get
    def unavailable
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            player = User.find(@current_user)
            @teams=[];
            unavailable_partnerships=player.partnerships.where(:state=>1)+player.partnerships.where(:state=>4)
            unavailable_partnerships.each do |partnership|
                team=Team.find(partnership.team_id)
                partner=team.users.where.not(:id=>@current_user).first
                @teams.push({
                    "id": team["id"],
                    "is_official": team["is_official"],
                    "name": team["is_official"]? team["name"]: nil,
                    "image_url": team["is_official"] ? team["image_url"] : nil,
                    "partner":{
                        "id":partner["id"],
                        "nickname":partner["nickname"],
                        "image_url":partner["image_url"]
                    }
                })
                @status=200;
            end
        end
    end

    #post
    def create
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            if params.has_key?(:partner)

                partner = User.where(:nickname=>params[:partner]).first

                if partner!=nil
                    if !TeamService.check(partner["id"], @current_user)

                        team = Team.new(is_official: params[:is_official])
                        if params.has_key?(:name)
                            team["name"]=params[:name]
                        end
                        if params.has_key?(:image_url)
                            team["image_url"]=params[:image_url]
                        end
                        
                        if team.save
                            partnership_1 = Partnership.create(team:team, user:User.find(@current_user), state:1)
                            partnership_2 = Partnership.create(team:team, user:partner, state:2)
                            if partnership_1 && partnership_2
                                render json: {message:"OK", status:200}.to_json
                            else
                                render json: {message:"Relationship could not be created", status:500}.to_json
                            end
                        else
                            render json: {message:"Team could not be created", status:500}.to_json
                        end
                    else
                        render json: {message:"Team already exists", status:500}.to_json
                    end
                else
                    render json: {message:"User to create team not found", status:500}.to_json
                end
            else
                render json: {message:"You need to define your partner", status:500}.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    #put
    def join
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            team=Team.find(params[:id]);
            if team!=nil
                relation_1=Partnership.where(:team=>team, :user=>User.find(@current_user)).first

                if relation_1!=nil
                    relation_1["state"]=3;
                    relation_1.save;
                    relation_2=Partnership.where(:team=>team, :state=>1)
                    relation_2=3;
                    relation_2.save;

                    render json:{message:"OK", status:200}.to_json
                else
                    render json: {message:"You have no right to join that team", status:500}.to_json
                end
            else
                render json: {message:"You attempted to join an invalid team", status:500}.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    #put
    def leave
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            team=Team.find(params[:id]);
            if team!=nil
                relation_1=Partnership.where(:team=>team, :user=>User.find(@current_user)).first

                if relation_1!=nil
                    relation_1["state"]=4;
                    relation_1.save;
                    relation_2=Partnership.where(:team=>team, :user=>3).first
                    relation_2=4;
                    relation_2.save;

                    render json:{message:"OK", status:200}.to_json
                else
                    render json: {message:"You have no right on that team", status:500}.to_json
                end
            else
                render json: {message:"You attempted to access an invalid team", status:500}.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    #post
    def restore
        get_user_by_token(request)
        if @status!=500 && @current_user!=0
            team=Team.find(params[:id]);
            if team!=nil
                relation_1=Partnership.where(:team=>team, :user=>User.find(@current_user)).first

                if relation_1!=nil
                    relation_1["state"]=3;
                    relation_1.save;
                    relation_2=Partnership.where(:team=>team, :user=>4).first
                    relation_2=3;
                    relation_2.save;

                    render json:{message:"OK", status:200}.to_json
                else
                    render json: {message:"You have no right on that team", status:500}.to_json
                end
            else
                render json: {message:"You attempted to access an invalid team", status:500}.to_json
            end
        else
            render json: {message:"Unauthorized", status:500}.to_json
        end
    end

    protected
    def set_default_response_format
      request.format = :json
    end

end
