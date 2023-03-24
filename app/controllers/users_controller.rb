class UsersController < ApplicationController

    def create
        if user_params[:password] == params[:password_confirmation]
            user = User.create(user_params)
            session[:user_id] = user.id
            render json: user
        else
            render json: {error: 'password confirmation should matchinput password'}, status: :unprocessable_entity
        end

    end

    def show
        user = User.find_by(id: session[:user_id])
        if user
            render json: user
        else
            render json: {error:'Not Authorized'}, status: 401
        end
    end

    

    private

    def user_params
        params.permit(:username, :password)
    end
end
