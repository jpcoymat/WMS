class AllocationStrategyLine < ActiveRecord::Base

  belongs_to 	:allocation_strategy
  belongs_to	:allocation_zone
  validates   :allocation_zone_id, :allocation_strategy_id, :containerization_method, :minimum_pick_uom, :containerization_level, :order_sequence, presence: true
  
  def self.containerization_methods
    ["Pick As Is", "Containerize", "Palletize"]
  end
  
  def self.containerization_levels
    ["Order", "Customer","Wave"]    
  end
  
  def self.minimum_pick_uoms
    ["Logical Each", "Logical Case", "Logical Pallet", "Root Container"]
  end


end
