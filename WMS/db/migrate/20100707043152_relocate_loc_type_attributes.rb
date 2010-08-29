class RelocateLocTypeAttributes < ActiveRecord::Migration

  def self.up
    add_column      :locations,       :available_for_storage,     :boolean, :null => false, :default => false
    add_column      :locations,       :available_for_allocation,  :boolean, :null => false, :default => false
    add_column      :locations,       :allocation_zone_id,        :integer
    add_column      :locations,       :storage_zone_id,           :integer
    add_column      :locations,       :allocation_strategy_id,    :integer
    add_column      :locations,       :mix_products,              :boolean, :null => false, :default => false
    add_column      :locations,       :collapse_containers,       :boolean, :null => false, :default => false
    add_column      :locations,       :replenishable,             :boolean, :null => false, :default => false
    
    remove_column   :location_types,  :allocation_strategy_id
    remove_column   :location_types,  :available_for_storage
    remove_column   :location_types,  :available_for_allocation
    remove_column   :location_types,  :allocation_zone_id    
    remove_column   :location_types,  :storage_zone_id
    remove_column   :location_types,  :mix_products
    remove_column   :location_types,  :collapse_containers
    remove_column   :location_types,  :replenishable
    
  end

  def self.down
  end
end
