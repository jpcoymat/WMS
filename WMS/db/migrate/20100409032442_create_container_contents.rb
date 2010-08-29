class CreateContainerContents < ActiveRecord::Migration
  def self.up
    create_table :container_contents do |t|
      t.integer :container_id, :null => false
      t.integer :product_id, :null => false
      t.integer :lot_id, :null => false
      t.integer :product_status
      t.decimal :quantity, :null => false, :precision => 8, :scale => 2
      t.integer :receipt_line_id
      t.integer :order_line_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :container_contents
  end
end
