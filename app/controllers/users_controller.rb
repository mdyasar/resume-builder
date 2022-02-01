class UsersController < ApplicationController
  def new
    @user= User.new
  end

  def create
    @user= User.new(user_params)
    if @user.save
      @user.profile = Profile.new(profile_params)
      @user.profile.educations.create
      # @user.profile.projects.create
      flash[:success] = "Account created successfully!"
      redirect_to login_path
    else
      flash.now.alert = "Oops, couldn't create account."
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def profile_params
    params.require(:user).permit(:name)
  end
end
