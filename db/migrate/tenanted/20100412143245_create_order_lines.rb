class CreateOrderLines < ActiveRecord::Migration
  def self.up
    create_table :order_lines do |t|
      t.integer :line_sequence_number, :null => false
      t.integer :product_id, :null => false
      t.integer :lot_id
      t.integer :product_status_id
      t.integer :product_package_id
      t.integer :quantity_ordered, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :order_lines
  end
end
