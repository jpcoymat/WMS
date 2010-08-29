class CreateStorageZones < ActiveRecord::Migration
  def self.up
    create_table :storage_zones do |t|
      t.string :code, :null => false, :unique => true, :limit => 5
      t.string :name, :null => false, :unique => true

      t.timestamps
    end
  end

  def self.down
    drop_table :storage_zones
  end
end
