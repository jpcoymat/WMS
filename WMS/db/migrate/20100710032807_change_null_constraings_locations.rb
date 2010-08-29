class ChangeNullConstraingsLocations < ActiveRecord::Migration

  def self.up
    change_column :locations, :zone,      :string,  :null => false
    change_column :locations, :aisle,     :string,  :null => false
    change_column :locations, :bay,       :string,  :null => false
    change_column :locations, :level,     :string,  :null => false
    change_column :locations, :position,  :string,  :null => false
  end

  def self.down
  end
end
