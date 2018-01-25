json.set! :players do
    json.array! @players, :id, :email, :nickname, :age, :image_url
end