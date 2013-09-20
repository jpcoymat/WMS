class RenameStatusDockDoor < ActiveRecord::Migration

  def self.up
    rename_column :dock_doors,:status, :state
  end

  def self.down
  end
end
