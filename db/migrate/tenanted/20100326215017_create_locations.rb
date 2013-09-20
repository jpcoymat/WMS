class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.integer :warehouse_id, :null => false
      t.string :zone, :null => false, :limit => 4
      t.string :aisle, :null => false, :limit => 4
      t.string :bay, :null => false, :limit => 4
      t.string :level, :null => false, :limit => 4
      t.string :position, :null => false, :limit => 4
      t.decimal :length, :scale => 2, :precision => 8, :null => false
      t.decimal :width, :scale => 2, :precision => 8, :null => false
      t.decimal :height, :scale => 2, :precision => 8, :null => false
      t.string :location, :null => false, :unique => true
      t.integer :pick_travel_sequence
      t.integer :storage_travel_sequence
      t.integer :storage_zone_id
      t.boolean :fixed_pick_location_flag

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
