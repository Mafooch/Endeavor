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
    @skills = @project.skills
    @interests = @project.interests
  end

  def index
    @projects = Project.all
    @skill_tags = Project.tag_counts_on(:skills).where("name like ?", "%#{params[:q]}%")
    respond_to do |format|
      format.html
      format.json { render :json => @skill_tags }
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :proposal, :skill_list, :interest_list)
  end
end
