# Migration for the Roomer.tenants_table
class RoomerCreateTenants < ActiveRecord::Migration
  def self.up
    create_table(:tenants) do |t|
      t.string :url_identifier
      t.string :schema_name

      # Add additional columns here
      # t.string :name
      t.timestamps
    end

    add_index :tenants, :url_identifier, :unique => true
    add_index :tenants, :schema_name, :unique => true
  end

  def self.down
    drop_table :tenants
  end
end
