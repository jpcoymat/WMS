class AddUserAssignment < ActiveRecord::Migration
  def self.up
	add_column :assignment_details, :user_id, :integer
  end

  def self.down
	remove_column :assignment_details, :user_id
  end
end
