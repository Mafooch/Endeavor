class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.string :proposal, null: false
      t.string :user_id, null: false

      t.timestamps null: false
    end

    add_index :projects, [:name, :user_id], unique: true
    add_index :projects, [:proposal, :user_id], unique: true
  end
end
