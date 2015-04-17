class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      flash[:success] = "Project created successfully!"
      redirect_to root_path
    else
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
      flash[:notice] = "Update failed"
      render :new
    end
  end

  def show
    @project = Project.find(params[:id])
    @recommended_users = @project.recommended_users
    @skills = @project.skills
    @interests = @project.interests
  end

  def index
    @projects = Project.all
  end

  def all_skills
    project_skill_tags = Project.tag_counts_on(:skills).where(
      "name like ?", "%#{params[:q]}%")
    user_skill_tags = User.tag_counts_on(:skills).where(
      "name like ?", "%#{params[:q]}%")
    all_skill_tags = project_skill_tags + user_skill_tags
    all_skill_tags.uniq!

    respond_to do |format|
      format.json { render json: all_skill_tags }
    end
  end

  def all_interests
    project_interest_tags = Project.tag_counts_on(:interests).where(
      "name like ?", "%#{params[:q]}%")
    user_interest_tags = User.tag_counts_on(:interests).where(
      "name like ?", "%#{params[:q]}%")
    all_interest_tags = project_interest_tags + user_interest_tags
    all_interest_tags.uniq!

    respond_to do |format|
      format.json { render json: all_interest_tags }
    end
  end

  def destroy
    @project = current_user.projects.find(params[:id])
    @project.destroy
    flash[:success] = "Project deleted successfully"
    redirect_to(projects_path)
  end

  private

  def project_params
    params.require(:project).permit(:name, :proposal, :skill_list, :interest_list)
  end
end
