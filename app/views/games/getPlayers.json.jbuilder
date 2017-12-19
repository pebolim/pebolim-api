
json.status @status

json.set! :players do
    json.array! @players.each do |player|
        json.id player.id
        json.nickname player.nickname
        json.image_url player.image_url
    end
end


