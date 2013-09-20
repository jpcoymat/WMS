class CreatePurchaseOrders < ActiveRecord::Migration
  def self.up
    create_table :purchase_orders do |t|
      t.integer :supplier_id
      t.date :ship_date
      t.integer :company_id
      t.string :purchase_order_number
      t.integer :purchase_order_type_id

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_orders
  end
end
