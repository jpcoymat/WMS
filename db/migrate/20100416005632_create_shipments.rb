class CreateShipments < ActiveRecord::Migration
  def self.up
    create_table :shipments do |t|
      t.string :trailer_number, :null => false
      t.date :arrival_date
      t.date :departure_date
      t.string :direction, :null => false, :limit => 25
      t.integer :dock_door_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :shipments
  end
end
