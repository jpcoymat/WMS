class CreateInventoryAdjustments < ActiveRecord::Migration
  def self.up
    create_table :inventory_adjustments do |t|
      t.integer :inventory_adjustment_type_id,  :null => false
      t.string :adjustment_type,                :null => false, :limit => 10
      t.decimal :adjustment_quantity,           :scale => 2,    :precision => 8,  :null => false
      t.integer :user_id,                       :null => false
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :inventory_adjustments
  end
end
