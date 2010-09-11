class AllocationZone < ActiveRecord::Base

  belongs_to	:warehouse
  has_many      :allocation_strategy_lines
  has_many      :locations
  validates	:code, :uniqueness => true
  validates	:code, :name, :warehouse_id, :presence => true
  
  def deleteable?
    self.allocation_strategy_lines.empty? and self.locations.empty?
  end

end
