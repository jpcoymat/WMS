class LocationTypeMaxWeight < ActiveRecord::Migration

  def self.up
    add_column  :location_types,  :maximum_weight,  :decimal,   :scale => 2,  :precision => 8
  end

  def self.down
  end
end
