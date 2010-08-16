class LocationAddAllocationZoneId < ActiveRecord::Migration

  def self.up
    add_column  :locations, :allocation_zone_id, :integer
  end

  def self.down
  end
end
