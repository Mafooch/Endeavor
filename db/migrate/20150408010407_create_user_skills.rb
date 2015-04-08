class CreateUserSkills < ActiveRecord::Migration
  def change
    create_table :user_skills do |t|
      t.integer :skill_id, null: false
      t.integer :user_id, null: false
      t.integer :proficiency

      t.timestamps null: false
    end

    add_index :user_skills, [:skill_id, :user_id], unique: true
  end
end
