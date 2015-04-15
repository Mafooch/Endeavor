class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @skills = @user.skills
    @interests = @user.interests
    @projects = @user.projects
  end

  def index
    @users = User.all
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.update(params[:id], user_params)
    if @user.save
      flash[:success] = "Profile updated successfully"
      redirect_to(user_path(@user))
    else
      flash[:notice] = "Update failed"
      render :new
    end
  end

  private

  # def user_params
  #   params.require(:user).permit(:)
  # end
end
