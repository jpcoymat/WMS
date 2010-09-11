class AllocationStrategy < ActiveRecord::Base

  belongs_to              :warehouse
  has_many                :allocation_strategy_lines, :dependent => :destroy, :order => :order_sequence
  has_many                :product_warehouse_setups
  has_many                :allocation_strategy_rules
  has_many                :product_location_assignments

  validates   :name, :code, :warehouse_id, :presence => true
  validates   :code, :scope => :warehouse_id, :uniqueness => true
  
  def deleteable?
    self.product_warehouse_setups.empty? and self.allocation_strategy_rules.empty? and self.product_location_assignments.empty?
  end

end
