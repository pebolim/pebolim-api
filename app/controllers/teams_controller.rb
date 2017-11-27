class TeamsController < ApplicationController
    before_action :set_default_response_format
    
    def index
        @teams = Team.all
    end

    def show
        @team = Team.find(find_by_ID)
    end

    #post
    def create
        @team = Team.new();

        if @team.save
            redirect_to @team
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
