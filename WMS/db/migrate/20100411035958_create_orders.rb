class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.string :order_number
      t.date :ship_date
      t.integer :customer_id
      t.date :received_date
      t.integer :order_priority
      t.integer :order_type_id
      t.string :ship_addres_1
      t.string :ship_address_2
      t.string :ship_city
      t.string :ship_postal_code
      t.string :ship_state
      t.integer :ship_country_id

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
