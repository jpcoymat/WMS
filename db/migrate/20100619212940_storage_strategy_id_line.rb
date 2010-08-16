class StorageStrategyIdLine < ActiveRecord::Migration

  def self.up
	add_column :storage_strategy_lines, :storage_strategy_id, :integer, :null => false
  end

  def self.down
  end
end
