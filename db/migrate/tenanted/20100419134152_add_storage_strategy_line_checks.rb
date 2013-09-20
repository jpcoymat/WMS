class AddStorageStrategyLineChecks < ActiveRecord::Migration
  def self.up
	add_column :storage_strategy_lines, :check_volume, :boolean, :null => false, :default => false
	add_column :storage_strategy_lines, :check_dimensions, :boolean, :null => false, :default => false
	add_column :storage_strategy_lines, :check_containers, :boolean, :null => false, :default => false
  end



  def self.down
  end
end
