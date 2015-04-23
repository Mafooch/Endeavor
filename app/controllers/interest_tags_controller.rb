class InterestTagsController < ApplicationController
  def index
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
end
