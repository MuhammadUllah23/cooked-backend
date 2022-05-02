class ApplicationController < ActionController::API
    def encoded_token(payload)
        #payload => { beef: 'steak' }
        JWT.encode(payload, 'my_s3cr3t')
        # jwt string: "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"
    end

    def auth_header
        # { 'Authorization': 'Bearer <token>' }
        request.headers['Authorization']
    end

    def decoded_token(token)
        # If server receives bad token, it can lead to a 500 Internal Server Error. 
        # But the rescue syntax accounts for the invalid token by returning nil.
        # It keeps the server from crashing.
        if auth_header
            token = auth_header.split(' ')[1]
            # headers: { 'Authorization': 'Bearer <token>' }
            begin
                JWT.decode(token, 'my_s3cr3t', tru, algorithm: 'HS256')
                # JWT.decode => [{ "beef"=>"steak" }, { "alg"=>"HS256" }]
            rescue JWT::DecodeError
                nil
            end
        end
    end

    
end
