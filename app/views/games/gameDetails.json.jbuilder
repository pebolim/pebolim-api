json.set! :game do
    json.id @game.id
    json.url @game.url
    json.is_private @game.is_private
    json.max_goals @game.max_goals
    json.local @game.local
    json.owner_id @game.owner_id
    json.start_date @game.start_date
    json.finish_date @game.finish_date
    json.result1 @game.result1
    json.result2 @game.result2

    json.set! :teams do
        json.array! @teams.each do |team|
            json.id team.id
            json.name team.name
            json.attacker team.attacker
            json.defender team.defender
        end
    end
end

