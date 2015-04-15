class UpdateUserIdOnProjectsTable < ActiveRecord::Migration
 def up
   remove_column :projects, :user_id
 end

 def down
   add_column :projects, :user_id, :string, null: false
 end
end
