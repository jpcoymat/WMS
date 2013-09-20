class CreateProductWarehouseSetups < ActiveRecord::Migration
  def self.up
    create_table :product_warehouse_setups do |t|
      t.integer :product_id,  :null => false     
      t.integer :warehouse_id,  :null => false
      t.integer :product_status_id, :null => false
      t.string  :lot_management_type,   :null => false, :limit => 10
      t.integer :allocation_strategy_id
      t.integer :storage_strategy_id

      t.timestamps
    end
    
    #drop_table :product_warehouse_settings
  end

  def self.down
    drop_table :product_warehouse_setups
  end
end
