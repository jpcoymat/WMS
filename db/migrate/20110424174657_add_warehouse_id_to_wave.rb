class AddWarehouseIdToWave < ActiveRecord::Migration
  def self.up
    add_column :waves, :warehouse_id, :integer, :null => false
  end

  def self.down
  end
end
