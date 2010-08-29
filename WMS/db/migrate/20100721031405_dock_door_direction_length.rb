class DockDoorDirectionLength < ActiveRecord::Migration

  def self.up
	change_column	:dock_doors, :direction, :string, :null => false, :limit => 25 
  end

  def self.down
  end
end
