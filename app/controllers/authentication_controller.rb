class AuthenticationController < ApplicationController

  def signin
    
    @success = false
    @token = nil

    if params.has_key?(:email) && params.has_key?(:password) && params.has_key?(:nickname)
      
      matched = /[^'"\[\]{}]{6,15}/.match(params[:password])

      if matched.to_s.eql?(params[:password])
        
        @user = User.new(
          nickname: params[:nickname],
          email: params[:email],
          password: Digest::SHA256.hexdigest(params[:password]),
          age: params[:age]
          )
        @user.save
        
        filename = File.join(Rails.root, 'keys', 'private_key.pem')
        rsa_private = OpenSSL::PKey::RSA.new(File.read(filename))
        
        payload = {
          :user_id => @user["id"],
          :ip_address => request.remote_ip,
          :expiration_date => DateTime.now + 3.hours
        }
    
        @token = JWT.encode payload, rsa_private, 'RS256'
        @status = 200
      else
        @status = 500
        @message="Your password cannot have the following characters=> ^'\"[]{}  and need to have between 6 and 15 characters."
      end
    else
      @status = 500
      @message="Teh fields 'email', 'password' and 'nickname' are necessary"
    end
    render "login"
  end

  def login

    @status = 500
    @token = nil

    if params.has_key?(:email) && params.has_key?(:password)

      @user = User.where(
        'email' => params[:email],
        'password' => Digest::SHA256.hexdigest(params[:password])
        ).first

      if @user!=nil
        filename = File.join(Rails.root, 'keys', 'private_key.pem')
        rsa_private = OpenSSL::PKey::RSA.new(File.read(filename))
        
        payload = {
          :user_id => @user["id"],
          :ip_address => request.remote_ip,
          :expiration_date => DateTime.now + 3.hours
        }
    
        @token = JWT.encode payload, rsa_private, 'RS256'
        @status = 200
      else
        @status = 500
        @message = "Invalid credentials"
      end
    end
  end
    
end
