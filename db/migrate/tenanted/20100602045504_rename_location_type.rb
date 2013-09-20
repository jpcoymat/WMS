class RenameLocationType < ActiveRecord::Migration

  def self.up
    rename_column :locations, :type, :location_type
  end

  def self.down
  end
end
