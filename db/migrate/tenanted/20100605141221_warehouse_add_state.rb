class WarehouseAddState < ActiveRecord::Migration

  def self.up
	  add_column :warehouses, :state, :string, :limit => 25
  end

  def self.down
  end
end
