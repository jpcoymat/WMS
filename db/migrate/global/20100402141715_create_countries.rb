class CreateCountries < ActiveRecord::Migration
  def self.up
    create_table :countries do |t|
      t.string :name, :null => false
      t.string :iso_code, :limit => 3
      t.string :code, :null => false, :limit => 3
      t.string :language, :limit => 25
      t.integer :telephone_country_code, :limit => 3

      t.timestamps
    end
  end

  def self.down
    drop_table :countries
  end
end
