class LocationAddAlias < ActiveRecord::Migration
  def self.up
	add_column :locations, :alias, :string, :limit => 100
  end

  def self.down
	remove_column :locations, :alias
  end
end
