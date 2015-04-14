class DropSkills < ActiveRecord::Migration
  def up
    drop_table :skills
  end
  def down
    create_table :skills do |t|
      t.string :name, null: false

      t.timestamps null: false
    end

    add_index :skills, :name, unique: true
  end
end
