class UsersController < ApplicationController
    # configure users to login and signup using JWT authenticity

    def create
        @user = User.create(user_params)
        if @user.valid?
            render json: { user: UserSerializer.new(@user)}, status: :created
        else
            render json: { error: 'failed to create user' }, status: :unprocessable_entity
        end
    end
    
end
