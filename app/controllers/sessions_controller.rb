class SessionsController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        if user &.authenticate(params[:password_digest])
            session[:user_id] = user.id
            render json: user, status: :created
        else
            render json: {error: "Invalid username or password"}
        end
    end
end
