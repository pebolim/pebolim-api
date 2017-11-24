json.set! :players do
    json.array! @players, :id, :name, :username, :score
end