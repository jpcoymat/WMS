class CreateCustomerTypes < ActiveRecord::Migration
  def self.up
    create_table :customer_types do |t|
      t.integer :company_id, :null => false  
      t.string :code, :null => false, :limit => 5   
      t.string :description, :limit => 25

      t.timestamps
    end
  end

  def self.down
    drop_table :customer_types
  end
end
