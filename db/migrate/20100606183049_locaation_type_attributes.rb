class LocaationTypeAttributes < ActiveRecord::Migration

  def self.up
    add_column  :location_types, :length,                     :decimal,   :scale => 2, :precision => 8, :null => false
    add_column  :location_types, :width,                      :decimal,   :scale => 2, :precision => 8, :null => false
    add_column  :location_types, :height,                     :decimal,   :scale => 2, :precision => 8, :null => false
    add_column  :location_types, :storage_zone_id,            :integer
    add_column  :location_types, :replenishable,              :boolean
    add_column  :location_types, :mix_products,               :boolean,   :null => false, :default => false
  	add_column  :location_types, :collapse_containers,        :boolean,   :null => false, :default => false
  	add_column  :location_types, :maximum_containers,         :integer
  	add_column  :location_types, :available_for_storage,      :boolean,   :null => false, :default => true
  	add_column  :location_types, :available_for_allocation,   :boolean,   :null => false, :default => true
  	add_column  :location_types, :allocation_zone_id,         :integer
    
    remove_column :locations, :length
    remove_column :locations, :width
    remove_column :locations, :height
    remove_column :locations, :storage_zone_id
    remove_column :locations, :mix_products
    remove_column :locations, :collapse_containers
    remove_column :locations, :maximum_containers
    remove_column :locations, :available_for_storage
    remove_column :locations, :available_for_allocation
    remove_column :locations, :allocation_zone_id
    
    rename_column :locations, :location_type,                 :location_type_id
    
    
  end

  def self.down
  end
end
