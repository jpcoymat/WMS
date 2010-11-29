class AddStatusToDockDoor < ActiveRecord::Migration

  def self.up
    add_column :dock_doors, :status, :string
  end

  def self.down
  end
end
