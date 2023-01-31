class SessionsController < ApplicationController
    def create
        @user = User.find_by_credentials(
            params[:user][:username],
            params[:user][:password]
        )

        if @user.nil?
            flash.now[:errors] = ["Incorrect Username, Password combination. Please try again."]
            @user = User.new(username: params[:user][:username])
            render :new
        else
            login!(@user)
            redirect_to user_url(@user)
        end
    end

    def new
        @user = User.new
        render :new
    end

    def destroy
        logout!
        redirect_to new_session_url
    end
end