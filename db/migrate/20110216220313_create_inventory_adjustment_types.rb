class CreateInventoryAdjustmentTypes < ActiveRecord::Migration
  def self.up
    create_table :inventory_adjustment_types do |t|
      t.string :code,         :limit => 10, :null=> false
      t.string :name,         :limit => 25, :null=> false
      t.string :description,  :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_adjustment_types
  end
end
