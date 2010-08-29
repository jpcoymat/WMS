class CreateLocationTypes < ActiveRecord::Migration
  def self.up
    create_table  :location_types do |t|
      t.string  :location_type, :null => false, :limit => 25
      t.integer :zone
      t.integer :aisle
      t.integer :bay
      t.integer :level
      t.integer :position
      t.integer :warehouse_id, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :location_types
  end
end
