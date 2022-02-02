class UsersController < ApplicationController
  def new
    @user= User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user= User.new(user_params)
    if @user.save
      Profile.create(user: @user)
      log_in(@user)
      redirect_to(edit_url)
    else
      flash.now.alert = "Oops, couldn't create account."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
