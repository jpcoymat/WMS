class AddWarehouseIdToShipment < ActiveRecord::Migration

  def self.up
	add_column :shipments, :warehouse_id, :integer, :null => false
  end

  def self.down
  end
end
