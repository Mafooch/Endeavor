require 'rails_helper'

# include RecommendationsHelper

describe RecommendationsHelper do
  describe "recommendation_valid?", focus: true do
    context "users and project exist" do
      let!(:project_1) { FactoryGirl.create(:project) }
      let!(:project_2) { FactoryGirl.create(:project) }

      it "returns false when recommendation class and recommendation_for class
        are the same" do
        expect(recommendation_valid?(project_1, project_2)).to eq false
        expect(recommendation_valid?(project_1.user, project_2.user)).to eq false
      end

      it "returns false when recommendation and recommendation_for
        are the same object." do
        expect(recommendation_valid?(project_1, project_1)).to eq false
      end

      it "returns false when the recommendation object is associated with
        the recommended_for object e.g. a user can't be recommended a project
        they own" do
        expect(recommendation_valid?(project_1.user, project_1)).to eq false
        expect(recommendation_valid?(project_1, project_1.user)).to eq false
      end

      it "returns true when non the recommendation is neither associated with
        or of the same class as the recommended_for object" do
        expect(recommendation_valid?(project_1, project_2.user)).to eq true
        expect(recommendation_valid?(project_2.user, project_1)).to eq true
      end
    end
  end

  describe "fetch_recommendations" do
    context "projects and users with tagged skills and interests exist" do
      let!(:project) do
        FactoryGirl.create(:project, skill_list: "ruby, rails,
          css, javascript, technical writing, video production",
          interest_list: "film, fitness, technology")
      end
      let!(:irrelevant_user) { FactoryGirl.create(:user) }
      let!(:relevant_user) do
        FactoryGirl.create(:user, skill_list: "ruby, rails")
      end
      let!(:most_relevant_user) do
        FactoryGirl.create(:user, skill_list: "ruby, python",
          interest_list: "film, big data")
      end

      it "returns and orders the users that best match the skills and interests
        of the project" do
        expect(project.recommended_users[0][0]).to eq most_relevant_user
        expect(project.recommended_users[1][0]).to eq relevant_user
      end

      it "does not return users that have no matches" do
        expect(project.recommended_users.include?([irrelevant_user]) == false)
      end
    end
  end
end
