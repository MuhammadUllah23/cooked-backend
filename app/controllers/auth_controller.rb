class AuthController < ApplicationController
    skip_before_action :authorized, only [:create]

    def create 
        @user = User.find_by(username: user_login_params[:username])

        if @user && @user.authenticate(user_login_params[:password])
            # encode token comes from Application Controller
            token = encoded_token({user: @user.id})
            render json: { user: UserSerializer.new(@user), jwt: token }, status: :accepted
        else
             render json: { message: 'Invalid username or password' }, status: :unauthorized
        end
    end

    private

    def user_login_params
        # params { user: {username: 'Chandler Bing', password: 'hi' } }
        params.require(:user).permit(:username, :password)
    end
end
