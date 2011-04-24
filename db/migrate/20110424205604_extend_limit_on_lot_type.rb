class ExtendLimitOnLotType < ActiveRecord::Migration

  def self.up
    remove_column :product_warehouse_setups, :lot_management_type
    add_column    :product_warehouse_setups, :lot_management_type, :string,  :null => false,  :limit => 100
  end

  def self.down
  end
end
