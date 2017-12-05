json.result @success
json.token @token
json.set! :user do
    json.id @user.id
    json.nickname @user.nickname
end