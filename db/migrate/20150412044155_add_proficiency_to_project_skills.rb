class AddProficiencyToProjectSkills < ActiveRecord::Migration
  def change
    add_column :project_skills, :proficiency, :integer
  end
end
