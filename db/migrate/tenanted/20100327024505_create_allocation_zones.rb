class CreateAllocationZones < ActiveRecord::Migration
  def self.up
    create_table :allocation_zones do |t|
      t.string :code, :null => false, :unique => true
      t.string :name, :null => false, :unique => true
      t.string :description, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :allocation_zones
  end
end
