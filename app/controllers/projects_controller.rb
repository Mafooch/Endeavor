class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @skills = @project.skills
    @interests = @project.interests
  end

  def index
    @projects = Project.all
  end

  private

  def project_params
    params.require(:project).permit(:name, :proposal, :skill_list)
  end
end
