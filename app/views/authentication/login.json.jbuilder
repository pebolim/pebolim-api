json.status @status
json.token @token
json.set! :user do
    json.id @user.id
    json.nickname @user.nickname
    json.image @user.image_url
end