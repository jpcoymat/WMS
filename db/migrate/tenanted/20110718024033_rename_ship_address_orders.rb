class RenameShipAddressOrders < ActiveRecord::Migration
  def self.up
    rename_column :orders, :ship_addres_1, :ship_address_1
  end

  def self.down
  end
end
