class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @top_5_recommended_projects = fetch_recommendations(
      @user, Project)[0..4].to_h.keys
    @projects = @user.projects
    @skills = @user.skills
    @interests = @user.interests
  end

  def index
    @users = User.all
  end
end
