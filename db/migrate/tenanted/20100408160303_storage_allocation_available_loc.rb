class StorageAllocationAvailableLoc < ActiveRecord::Migration

  def self.up
	add_column :locations, :available_for_storage, :boolean, :null => false, :default => true
	add_column :locations, :available_for_allocation, :boolean, :null => false, :default => true
  end

  def self.down
  end
end
