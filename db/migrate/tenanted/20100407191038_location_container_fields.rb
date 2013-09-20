class LocationContainerFields < ActiveRecord::Migration

  def self.up
	add_column :locations, :collapse_containers, :boolean, :null => false, :default => false
	add_column :locations, :maximum_containers, :integer
  end

  def self.down
  end
end
