
json.status @status

json.set! :game do
    json.id @game.id
    json.url @game.url
    json.is_private @game.is_private
    json.local @game.local
    json.owner_id @game.owner.id
    json.owner_name @game.owner.nickname
    json.state @game.state
    json.start_date @game.start_date
    json.finish_date @game.finish_date
    json.match_day @game.match_day

    json.set! :goals do
        json.array! @game.goals.each do |goal|
            json.user goal.user_id
            json.time goal.time    
        end
    end

    json.set! :teams do
        json.array! @participations.each do |participation|
            json.id participation.team.id
            json.name participation.team.name
            json.is_winner participation.is_winner
            
            json.set! :players do
                json.array! participation.team.users.each do |user|
                    json.id user.id
                    json.nickname user.nickname
                    json.image_url user.image_url
                end
            end
        end
    end
end

