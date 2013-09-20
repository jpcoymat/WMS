class RemoveColumnStateFromDockDoors < ActiveRecord::Migration

  def self.up
    remove_column :dock_doors, :state
  end

  def self.down
  end
end
