class CreateStorageStrategyRules < ActiveRecord::Migration
  def self.up
    create_table :storage_strategy_rules do |t|
      t.integer  "warehouse_id",           :null => false
      t.integer  "order_sequence_number",  :null => false
      t.integer  "product_category_id"
      t.integer  "product_subcategory_id"
      t.integer  "uom_id"
      t.integer  "supplier_id"
      t.integer  "product_status_id"
      t.integer  "container_type_id"
      t.integer  "storage_strategy_id",    :null => false
      
      t.timestamps
    end
  end

  def self.down
    drop_table :storage_strategy_rules
  end
end
