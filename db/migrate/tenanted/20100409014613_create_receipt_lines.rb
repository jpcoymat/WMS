class CreateReceiptLines < ActiveRecord::Migration
  def self.up
    create_table :receipt_lines do |t|
      t.integer :receipt_id, :null => false
      t.string :lp, :null => false, :limit => 50
      t.integer :product_id, :null => false
      t.integer :product_package_id, :null => false
      t.integer :lot_id, :null => false
      t.integer :product_status_id
      t.decimal :quantity, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :receipt_lines
  end
end
