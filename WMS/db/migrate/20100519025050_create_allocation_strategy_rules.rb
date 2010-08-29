class CreateAllocationStrategyRules < ActiveRecord::Migration
  def self.up
    create_table :allocation_strategy_rules do |t|
      t.integer :warehouse_id,            :null => false
      t.integer :order_sequence,          :null => false
      t.integer :order_type_id
      t.integer :product_category_id
      t.integer :product_subcategory_id
      t.integer :allocation_strategy_id,  :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :allocation_strategy_rules
  end
end
