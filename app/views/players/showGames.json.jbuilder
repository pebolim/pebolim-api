json.set! :games do
        json.array! @games, :id, :matchDay
end