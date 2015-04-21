class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @recommended_projects = User.find(params[:id]).recommended_projects
    # this line comes first, so destroyed 'ideal project' will not be attached
    # to @user
    @user = User.find(params[:id])
    @projects = @user.projects
    @skills = @user.skills
    @interests = @user.interests
  end

  def index
    @users = User.all
  end
end
