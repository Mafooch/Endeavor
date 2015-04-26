require 'rails_helper'

describe RecommendationsHelper do
  describe "recommendation_valid?" do
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

  context "projects and users exist with tagged skills and interests" do
    let!(:project_1) do
      FactoryGirl.create(:project, skill_list: "ruby, rails",
        interest_list: "film, fitness")
    end
    let!(:project_2) do
      FactoryGirl.create(:project, skill_list: "writing, web design",
        interest_list: "film, books")
    end
    let!(:user_1) do
      FactoryGirl.create(:user, skill_list: "css, rails",
        interest_list: "film, books")
    end
    let!(:user_2) do
      FactoryGirl.create(:user, skill_list: "ruby, rails")
    end

    describe "fetch_recommendations" do
      it "returns and orders the users that best match the skills and interests
        of the project" do
        expect(fetch_recommendations(project_1, User)[0][0]).to eq user_1
        expect(fetch_recommendations(project_1, User)[1][0]).to eq user_2
      end

      it "returns and orders the projects that best match the skills and
        interests of the user" do
        expect(fetch_recommendations(user_1, Project)[0][0]).to eq project_1
        expect(fetch_recommendations(user_1, Project)[1][0]).to eq project_2
      end
    end

    describe "matches" do
      it "returns two objects matching skills and interests" do
        expect(matches(project_1, user_1)).to(
          eq [{"skill"=>"rails"}, {"interest"=>"film"}])
        expect(matches(user_2, project_1)).to(
          eq [{"skill"=>"ruby"}, {"skill"=>"rails"}])
      end
    end
  end
end
