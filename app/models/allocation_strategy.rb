class AllocationStrategy < ActiveRecord::Base

  belongs_to              :warehouse
  has_many                :allocation_strategy_lines, :dependent => :destroy, :order => :order_sequence
  has_many                :product_warehouse_setups
  has_many                :allocation_strategy_rules
  has_many                :product_location_assignments

  validates_presence_of   :name, :code, :warehouse_id
  validates_uniqueness_of :code, :scope => :warehouse_id
  
  def deleteable?
    self.product_warehouse_setups.empty? and self.allocation_strategy_rules.empty? and self.product_location_assignments.empty?
  end

end
