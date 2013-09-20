class AddPriorityToAssignments < ActiveRecord::Migration

  def self.up
    add_column :assignments, :priority, :integer
  end

  def self.down
    remove_column :assignments, :priority
  end
end
