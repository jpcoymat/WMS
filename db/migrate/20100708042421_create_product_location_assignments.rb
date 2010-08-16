class CreateProductLocationAssignments < ActiveRecord::Migration
  def self.up
    create_table :product_location_assignments do |t|
      t.integer :product_id,        :null => false
      t.integer :location_id,        :null => false
      t.integer :replenishment_at,  :null => false
      t.integer :maximum_quantity,  :null => false
      t.integer :warehouse_id,      :null => false
      t.integer :replenish_to,      :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :product_location_assignments
  end
end
