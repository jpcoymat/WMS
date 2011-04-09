class AddWarehouseIdToOrders < ActiveRecord::Migration
  def self.up
	add_column :orders, :warehouse_id, :integer, :null => false
  end

  def self.down
  end
end
