class SkillTagsController < ApplicationController
  def index
    project_skill_tags = Project.tag_counts_on(:skills).where(
      "name like ?", "%#{params[:q]}%")
    user_skill_tags = User.tag_counts_on(:skills).where(
      "name like ?", "%#{params[:q]}%")
      
    all_skill_tags = project_skill_tags & user_skill_tags

    respond_to do |format|
      format.json { render json: all_skill_tags }
    end
  end
end
