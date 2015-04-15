class AddIndexToProjectsOnNameUserIdAndProposalUserId < ActiveRecord::Migration
  def change
    add_index :projects, [:name, :user_id], unique: true
    add_index :projects, [:proposal, :user_id], unique: true
  end
end
