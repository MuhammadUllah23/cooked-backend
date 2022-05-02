class UsersController < ApplicationController
    # skip before_action :authorized only for create method
    skip_before_action :authorized, only: [:create]

    # Creats a new user  and issues a token if it has been sucessfully created.
    def create
        @user = User.create(user_params)
        if @user.valid?
            @token = encoded_token(user_id: @user.id)
            render json: { user: UserSerializer.new(@user), jwt: @token}, status: :created
        else
            render json: { error: 'failed to create user' }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

end
