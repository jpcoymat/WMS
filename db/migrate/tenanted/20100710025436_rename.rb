class Rename < ActiveRecord::Migration

  def self.up
    rename_column :locations, :location, :name
  end

  def self.down
  end
end
