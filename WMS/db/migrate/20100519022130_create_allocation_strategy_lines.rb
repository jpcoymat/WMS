class CreateAllocationStrategyLines < ActiveRecord::Migration
  def self.up
    create_table :allocation_strategy_lines do |t|
      t.integer :order_sequence,            :null => false
      t.integer :allocation_zone_id,        :null => false
      t.string  :containerization_method,   :null => false, :limit => 25
      t.string  :minimum_pick_uom,          :null => false, :limit => 25
      t.string  :containerization_level,    :null => false, :limit => 25

      t.timestamps
    end
  end

  def self.down
    drop_table :allocation_strategy_lines
  end
end
