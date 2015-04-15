class ProjectsController < ApplicationController
  before_action :authenticate_user!

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.new(project_params)
    binding.pry
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
    @skill_tags = Project.tag_counts_on(:skills).where("name like ?", "%#{params[:q]}%")
    # binding.pry
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
