json.set! :game do
    json.local @game.local
    json.match_day @game.match_day
    json.url @game.url
    json.is_private @game.is_private
    json.max_goals @game.max_goals
    json.result1 @game.result1 
    json.result2 @game.result2
    json.best_atacker @best_atacker
    json.best_defender @best_defender
    json.game_state_id @game_state
    json.owner_id @owner
    json.team1_id @team1
    json.team2_id @team2
end