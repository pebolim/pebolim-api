class ApplicationController < ActionController::API

    helper_method :get_user_by_token

    def get_user_by_token(request)
        @current_user = 0;

        filename = File.join(Rails.root, 'keys', 'public_key.pem');
        rsa_public = OpenSSL::PKey::RSA.new(File.read(filename));
        payload = JWT.decode request.headers["Authorization"], rsa_public, true, { :algorithm => 'RS256' }

        if payload[0]["ip_address"] == request.remote_ip && !DateTime.parse(payload[0]["expiration_date"]).past?
            @current_user = payload[0]["user_id"];
            @status=200
        else
            render json: {message:"Unauthorized", status:401}.to_json
        end
    end

end
