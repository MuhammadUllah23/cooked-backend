class ApplicationController < ActionController::API
    before_action :authorized

    # Authentication: Taking a username and password and authenticating that it is correct. Like logging a user in.
    # Authorization: Making sure the user that sends requests to the server is the same user that is logged in. It is authorizing that the user has access to a particular system.
    # JWT is authorizing users using a JSON Web Token to do the authorization.

    # The user information is stored in the token which means it is stored in the client and the server doesnt have to remember the token.
    # Which means you can use the same JSON web token across multiple servers.

    # Takes username, email, and password as paylaod and creates a JWT for User with Secret. 
    def encoded_token(payload)
        # payload => { beef: 'steak' }
        JWT.encode(payload, ENV["MY_S3CR3T"])
        # jwt string: "eyJhbGciOiJIUzI1NiJ9.eyJiZWVmIjoic3RlYWsifQ._IBTHTLGX35ZJWTCcY30tLmwU9arwdpNVxtVU0NpAuI"
    end

    def auth_header
        # { 'Authorization': 'Bearer <token>' }
        request.headers['Authorization']
    end

    # Verifies JWT Signature and Get User from User
    def decoded_token(token)
        # If server receives bad token, it can lead to a 500 Internal Server Error. 
        # But the rescue syntax accounts for the invalid token by returning nil.
        # It keeps the server from crashing.
        if auth_header
            token = auth_header.split(' ')[1]
            # headers: { 'Authorization': 'Bearer <token>' }
            begin
                JWT.decode(token, ENV["MY_S3CR3T"], true, algorithm: 'HS256')
                # JWT.decode => [{ "beef"=>"steak" }, { "alg"=>"HS256" }]
            rescue JWT::DecodeError
                nil
            end
        end
    end

    # Once decoded_token passes then it will find the user by its id and set it as @user.
    def current_user
        if decoded_token
            user_id = decoded_token[0]['user_id']
            @user = User.find_by(id: user_id)
        end
    end

    # Checks to see if user is logged in. The two !! is to make it a truthy value.
    def logged_in?
        !!current_user
    end

    # Set as before_action to make sure a user is logged in before anything else happens.
    def authorized
        render json: {message: 'Please log in'}, status: :unauthorized unless logged_in?
    end
    
end
