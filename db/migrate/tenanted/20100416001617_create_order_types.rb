class CreateOrderTypes < ActiveRecord::Migration
  def self.up
    create_table :order_types do |t|
      t.string :order_type, :null => false, :limit => 25, :unique => true
      t.string :description, :limit => 50

      t.timestamps
    end
  end

  def self.down
    drop_table :order_types
  end
end
