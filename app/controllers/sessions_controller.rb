class SessionsController < ApplicationController
    def create
        user = User.find_by(username:user_params[:username])
        if user&.authenticate(user_params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {error: 'Not Authorized'}, status: 401
        end

    end

    def destroy
        session.delete :user_id
        head :no_content
    end

    private
    def user_params
        params.permit(:username, :password)
    end
end
