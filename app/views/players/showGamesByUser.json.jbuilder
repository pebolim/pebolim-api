#json.set! :games do
#        json.array! @games do |game|
#                json.id game.id
#                json.match_day game.match_day
#               json.players @teams
#       end
#end
json.array! @teams