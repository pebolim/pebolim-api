json.set! :game do
    json.set! :id,  @game["id"]
    json.set! :teams do
        json.array! @teams, :id
    end
end