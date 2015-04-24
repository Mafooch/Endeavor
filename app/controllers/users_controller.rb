class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @top_5_recommended_projects = User.find(
      params[:id]).recommended_projects[0..4].to_h.keys
    # this line comes first, so destroyed 'ideal project' will not be attached
    # to @user
    @user = User.find(params[:id])
    @projects = @user.projects
    @skills = @user.skills
    @interests = @user.interests
    @test = fetch_recommendations(@user, Project)
  end

  def index
    @users = User.all
  end
end
