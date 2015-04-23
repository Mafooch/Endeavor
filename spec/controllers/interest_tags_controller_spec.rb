require 'rails_helper'

describe InterestTagsController do
  describe "GET index" do
    context "interest and skill tags exist" do
      let!(:user) { FactoryGirl.create(:user, interest_list: "art, film") }
      let!(:project) do
        FactoryGirl.create(:project, user: user, interest_list: "biking, books")
      end

      it "returns a list of json data that matches the wild card search" do
        get :index, q: "o", format: :json

        expect(response.body.include?("books"))
      end

      it "does not return a list of json data that does not match the wild card
        search" do
        get :index, q: "o", format: :json

        expect(response.body.include?("biking")).to eq(false)
      end
    end
  end
end
