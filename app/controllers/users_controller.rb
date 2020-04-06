class UsersController < ApplicationController
    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      @user.email.downcase!
      if @user.save
        session[:user_id] = @user.id.to_s
        redirect_to root_path, notice: 'Created User & Successfully logged in!'
      else
        flash.now.alert = "Oops, couldn't create account. Please make sure you are using a valid email and password and try again."
        render :new
      end
    end
  
  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :token_set)
  end
end
