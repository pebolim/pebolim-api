
json.status @status

json.set! :game do
    json.id @game.id
    json.url @game.url
    json.is_private @game.is_private
    json.local @game.local
    json.owner @game.owner.id
    json.state @game.state
    json.start_date @game.start_date
    json.finish_date @game.finish_date

    json.set! :teams do
        json.array! @participations.each do |participation|
            json.id participation.team.id
            json.name participation.team.name
            json.is_winner participation.is_winner
            json.goals participation.goals
        end
    end
end

