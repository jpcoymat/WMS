class CreateWarehouses < ActiveRecord::Migration
  def self.up
    create_table :warehouses do |t|
      t.string :name, :null => false, :limit => 100
      t.string :description, :null => false
      t.string :address_1, :null => false
      t.string :addresss_2
      t.string :city, :null => false
      t.string :postal_code
      t.integer :country_id, :null => false
      t.string :code, :null => false
      t.integer :company_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :warehouses
  end
end
