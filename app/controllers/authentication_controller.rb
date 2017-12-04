class AuthenticationController < ApplicationController

  def signin
    
    @success = false
    @token = nil

    if params.has_key?(:email) && params.has_key?(:password) && params.has_key?(:nickname) && params.has_key?(:age)
      
      matched = /[^'"\[\]{}]{6,15}/.match(params[:password])

      if matched.to_s.eql?(params[:password])
        
        user = User.new(
          nickname: params[:nickname],
          email: params[:email],
          password: Digest::SHA256.hexdigest(params[:password]),
          age: params[:age]
          )
        user.save
        
        filename = File.join(Rails.root, 'keys', 'private_key.pem')
        rsa_private = OpenSSL::PKey::RSA.new(File.read(filename))
        
        payload = {
          :user_id => user["id"],
          :ip_address => request.remote_ip,
          :expiration_date => DateTime.now + 3.hours
        }
    
        @token = JWT.encode payload, rsa_private, 'RS256'
        @success = true

      end
    end
    render "login"
  end

  def login

    @success = false
    @token = nil

    if params.has_key?(:email) && params.has_key?(:password)

      user = Player.where(
        'email' => params[:email],
        'password' => Digest::SHA256.hexdigest(params[:password])
        ).first

      if user!=nil
        filename = File.join(Rails.root, 'keys', 'private_key.pem')
        rsa_private = OpenSSL::PKey::RSA.new(File.read(filename))
        
        payload = {
          :user_id => user["id"],
          :ip_address => request.remote_ip,
          :expiration_date => DateTime.now + 3.hours
        }
    
        @token = JWT.encode payload, rsa_private, 'RS256'
        @success = true
      end
    end
  end
    
end
