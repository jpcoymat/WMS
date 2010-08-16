class LocationCleanup < ActiveRecord::Migration

  def self.up
    remove_column :locations, :location_type_id
    remove_column :locations, :max_staging_units
    remove_column :locations, :active 
    
    add_column    :locations, :location_type_id, :integer, :null => false
    
  end
  

  def self.down
  end
end
