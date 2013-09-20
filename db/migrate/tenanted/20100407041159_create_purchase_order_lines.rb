class CreatePurchaseOrderLines < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_lines do |t|
      t.integer :line_number
      t.integer :purchase_order_id, :null => false
      t.integer :product_id, :null => false
      t.decimal :quantity_uom, :null => false
      t.integer :uom_id
      t.text :comments

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_order_lines
  end
end
