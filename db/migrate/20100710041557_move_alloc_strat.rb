class MoveAllocStrat < ActiveRecord::Migration

  def self.up
    remove_column :locations, :allocation_strategy_id 
    add_column    :product_location_assignments,  :allocation_strategy_id, :integer, :null => false
  end

  def self.down
  end
end
