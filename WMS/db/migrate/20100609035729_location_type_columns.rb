class LocationTypeColumns < ActiveRecord::Migration

  def self.up
    add_column      :location_types, :code, :string,  :limit => 10, :null => false  
    add_column      :location_types, :name, :string,  :limit => 25, :null => false
    remove_column   :location_types, :location_type
  end

  def self.down
  end
end
