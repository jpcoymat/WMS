class LocationFields < ActiveRecord::Migration

  def self.up
	remove_column :locations, :fixed_pick_location_flag
	add_column :locations, :type, :string, :null => false, :limit => 10
	add_column :locations, :max_staging_units, :integer
  end

  def self.down
  end
end
