class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.string :name, :null => false, :limit => 50
      t.string :address_1, :null => false
      t.string :address_2
      t.string :city, :limit => false, :limit=>100 
      t.string :postal_code
      t.integer :country_id, :null => false
      t.string :iso_country_code

      t.timestamps
    end
  end

  def self.down
    drop_table :companies
  end
end
