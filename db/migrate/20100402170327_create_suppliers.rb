class CreateSuppliers < ActiveRecord::Migration
  def self.up
    create_table :suppliers do |t|
      t.string :name, :null => false, :limit => 100
      t.string :address_1
      t.string :address_2
      t.string :city
      t.string :postal_code
      t.integer :country_id
      t.string :state
      t.string :telephone, :null => false, :limit => 20
      t.string :email, :null =>false, :limit =>100
      t.string :description

      t.timestamps
    end
  end

  def self.down
    drop_table :suppliers
  end
end
