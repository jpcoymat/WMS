class ChangeLocationAttributes < ActiveRecord::Migration

  def self.up
    change_column :locations, :zone,      :string,  :null => true
    change_column :locations, :aisle,     :string,  :null => true
    change_column :locations, :bay,       :string,  :null => true
    change_column :locations, :level,     :string,  :null => true
    change_column :locations, :position,  :string,  :null => true
  end

  def self.down
  end
end
