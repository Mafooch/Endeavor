require 'rails_helper'

describe SkillTagsController do
  describe "GET index" do
    context "interest and skill tags exist" do
      let!(:user) { FactoryGirl.create(:user, skill_list: "ruby, rails") }
      let!(:project) do
        FactoryGirl.create(:project, user: user, skill_list: "c++, sketching")
      end

      it "returns a list of json data that matches the wild card search" do
        get :index, q: "i", format: :json

        expect(response.body.include?("rails"))
        expect(response.body.include?("sketching"))
      end

      it "does not return a list of json data that does not match the wild card
        search" do
        get :index, q: "i", format: :json

        expect(response.body.include?("ruby")).to eq(false)
        expect(response.body.include?("c++")).to eq(false)
      end
    end
  end
end
