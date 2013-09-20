class LocTypeComponents < ActiveRecord::Migration

  def self.up
	  add_column	:location_types, 	:zone, 		  :boolean, :null => false
	  add_column	:location_types, 	:aisle, 	  :boolean, :null => false
	  add_column	:location_types,	:bay,		    :boolean, :null => false
	  add_column	:location_types,	:level,		  :boolean, :null => false
	  add_column	:location_types,	:position,	:boolean, :null => false

  end

  def self.down
  end
end
