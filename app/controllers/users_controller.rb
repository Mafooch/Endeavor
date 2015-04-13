class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @user_skills = @user.user_skills
    @projects = @user.projects
  end

  def index
    @users = User.all
  end
end
