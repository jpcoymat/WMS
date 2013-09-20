class CreateCustomers < ActiveRecord::Migration
  def self.up
    create_table :customers do |t|
      t.integer :company_id, :null => false	
      t.string :name, :null => false, :limit => 100
      t.string :address_1, :limit => 100
      t.string :address_2, :limit => 100
      t.string :city, :limit => 50
      t.string :postal_code, :limit => 10
      t.string :state, :limit => 50
      t.integer :country_id
      t.string :telephone, :limit => 20
      t.string :email, :limit => 50
      t.string :code, :limit => 5

      t.timestamps
    end
  end

  def self.down
    drop_table :customers
  end
end
