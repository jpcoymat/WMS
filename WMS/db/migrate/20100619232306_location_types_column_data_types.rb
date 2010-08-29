class LocationTypesColumnDataTypes < ActiveRecord::Migration

  def self.up
	  remove_column	:location_types, 	:zone
	  remove_column	:location_types, 	:aisle
	  remove_column	:location_types,	:bay
	  remove_column	:location_types,	:level
	  remove_column	:location_types,	:position
	  
  end

  def self.down
  end
end
