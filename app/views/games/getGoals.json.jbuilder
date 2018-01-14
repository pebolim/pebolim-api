json.status @status
json.status @status

json.set! :game do
    json.id @game.id
    json.url @game.url
    json.is_private @game.is_private
    json.local @game.local
    json.state @game.state
    json.start_date @game.start_date
    json.finish_date @game.finish_date
    json.match_day @game.match_day
    json.to_teams @game.to_teams
end

json.goals @goals