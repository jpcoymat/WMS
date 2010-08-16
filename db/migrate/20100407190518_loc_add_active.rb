class LocAddActive < ActiveRecord::Migration

  def self.up
	add_column :locations, :active, :boolean, :null => false, :default => true
  end

  def self.down
  end
end
