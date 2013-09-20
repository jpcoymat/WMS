class CreateStorageStrategyLines < ActiveRecord::Migration
  def self.up
    create_table :storage_strategy_lines do |t|
      t.integer :order_sequence_number, :null => false
      t.integer :storage_zone_id, :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :storage_strategy_lines
  end
end
