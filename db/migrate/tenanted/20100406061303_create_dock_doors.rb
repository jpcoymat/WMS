class CreateDockDoors < ActiveRecord::Migration
  def self.up
    create_table :dock_doors do |t|
      t.string :name, :null => false, :limit => 10
      t.string :direction, :null => false, :limit => 1

      t.timestamps
    end
  end

  def self.down
    drop_table :dock_doors
  end
end
