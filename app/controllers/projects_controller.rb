class ProjectsController < ApplicationController
  before_action :authenticate_user!, except: [:all_skills, :all_interests]

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      flash[:success] = "Project created successfully!"
      redirect_to user_path(current_user)
    else
      flash[:error] = "Project creation failed"
      render :new
    end
  end

  def edit
    @project = current_user.projects.find(params[:id])
  end

  def update
    @project = Project.update(params[:id], project_params)
    if @project.save
      flash[:success] = "Project updated successfully"
      redirect_to(@project)
    else
      flash[:error] = "Update failed"
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @top_5_recommended_users = @project.recommended_users[0..4].to_h.keys
    @skills = @project.skills
    @interests = @project.interests
  end

  def index
    @projects = Project.all
  end

  def recommended_projects
    @recommended_projects = current_user.recommended_projects.to_h.keys
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    flash[:success] = "Project deleted successfully"
    redirect_to user_path(current_user)
  end

  private

  def project_params
    params.require(:project).permit(:name, :proposal, :skill_list, :interest_list)
  end
end
