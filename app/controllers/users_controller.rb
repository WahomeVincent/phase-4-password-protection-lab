class UsersController < ApplicationController
    def create
        user = User.create(user_params)
        if user.valid?
            render json: user, status: :created
        else
            render json: {error: user.errors.fullmessages}
        end
    end

    def show
        user = User.find_by(:username: params[:username])
        if user &.authenticate(params[:password_digest])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: "Invalid username or password"}
        end
    end

    private

    def user_params
        params.permit(:username, :password_digest)
    end
end
