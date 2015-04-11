class CreateProjectSkills < ActiveRecord::Migration
  def change
    create_table :project_skills do |t|
      t.integer :project_id, required: true
      t.integer :skill_id, required: true

      t.timestamps null: false
    end

    add_index :project_skills, [:project_id, :skill_id], unique: true
  end
end
