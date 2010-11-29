class ExchangeStorageStratForDockDoor < ActiveRecord::Migration
 
  def self.up
    rename_column :receipt_lines, :strorage_strategy_id, :dock_door_id
  end

  def self.down
  end
end
