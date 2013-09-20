class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.integer :company_id, :null => false
      t.string :name, :null => false, :limit => 100
      t.string :description, :limit => 200
      t.integer :supplier_id
      t.string :gtin_number
      t.string :upc_number
      t.string :image_filename, :limit => 100
      t.integer :default_allocation_strategy_id
      t.integer :default_putaway_strategy_id

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
