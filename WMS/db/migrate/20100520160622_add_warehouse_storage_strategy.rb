class AddWarehouseStorageStrategy < ActiveRecord::Migration

  def self.up
	add_column :storage_strategies, :warehouse_id, :integer, :null => false
  end

  def self.down
  end
end
