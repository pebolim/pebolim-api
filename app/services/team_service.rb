class TeamService
    
    def self.check(id_1, id_2)
        search = Team.where(:users=>[User.find(id_1), User.find(id_2)])
        if search==nil
            return false
        else
            return true
        end
    end
    
end