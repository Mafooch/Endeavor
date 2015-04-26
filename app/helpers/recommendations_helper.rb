module RecommendationsHelper
  def fetch_recommendations(rec_for, rec_type)
    skills_interests_to_match = rec_for.skill_list + rec_for.interest_list
    recommendations = rec_type.tagged_with([skills_interests_to_match], any: true)
    scored_recommendations = Hash.new

    recommendations.each do |rec|
      if recommendation_valid?(rec_for, rec)
        score = 0
        skill_intersection = rec.skill_list & rec_for.skill_list
        interest_intersection = rec.interest_list & rec_for.interest_list

        if skill_intersection.any? && interest_intersection.any?
          score += 3
          score = score + skill_intersection.count + interest_intersection.count
          scored_recommendations[rec] = score
        else
          score = skill_intersection.count + interest_intersection.count
          scored_recommendations[rec] = score
        end
      end
    end

    scored_recommendations = scored_recommendations.sort_by do |_rec, score|
      score
    end
    scored_recommendations.reverse
  end

  def recommendation_valid?(rec_for, rec)
    if rec_for != rec && rec_for.class != rec.class
      if rec_for.class == User
        return false if rec_for.projects.include?(rec)
      elsif rec_for.class == Project
        return false if rec_for.user == rec
      end
      return true
    else
      false
    end
  end

  def matches(object_1, object_2)
    matches = Array.new
    (object_1.skill_list & object_2.skill_list).each do |match|
      matches << { "skill" => match }
    end
    (object_1.interest_list & object_2.interest_list).each do |match|
      matches << { "interest" => match }
    end
    matches
  end
end
