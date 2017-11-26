class ApplicationController < ActionController::API

    def get_user_by_token(token, request)
        begin
            rsa_public = OpenSSL::PKey::RSA.new(File.read('../../keys/public_key.pem')) 
            payload = JWT.decode token, rsa_public, true, { :algorithm => 'RS256' }

            if (payload["ip_address"] == request.remote_ip) && (payload["expiration_date"] < DateTime.now)
                return payload["user_id"]
            else
                return 0
            end
        rescue
             return 0
        end
    end

end
