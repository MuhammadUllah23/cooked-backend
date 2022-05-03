class AuthController < ApplicationController
    skip_before_action :authorized, only [:create]

    private

    def user_login_params
        # params { user: {username: 'Chandler Bing', password: 'hi' } }
        params.require(:user).permit(:username, :password)
    end
end
