class AllocationZone < ActiveRecord::Base

  belongs_to                :warehouse
  has_many                  :allocation_strategy_lines
  has_many                  :locations
  validates_uniqueness_of   :code
  validates_presence_of     :code, :name, :warehouse_id
  
  def deleteable?
    self.allocation_strategy_lines.empty? and self.locations.empty?
  end

end
