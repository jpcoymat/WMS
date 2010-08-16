class RemoveProductWarehouseAttributes < ActiveRecord::Migration

  def self.up
	remove_column 	:products, :lot_management_type
	remove_column 	:products, :product_status_id
	remove_column	:products, :allocation_strategy_id
	remove_column	:products, :storage_strategy_id
  end

  def self.down
  end
end
