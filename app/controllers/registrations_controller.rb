class RegistrationsController < ApplicationController
    def new
        @user = User.new
    end

    def create
        @user = User.new(registration_params)
        if @user.save
            login @user
            session[:user_id] = @user.id
            redirect_to root_path, notice: "Successfully created Account!!!"
        else
            render :new, status: :unprocessable_entity
        end
    end

    private

    def registration_params
        params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
