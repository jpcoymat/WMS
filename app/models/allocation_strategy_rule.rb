class AllocationStrategyRule < ActiveRecord::Base

  belongs_to    :warehouse
  belongs_to    :order_type
  belongs_to   	:product_category
  belongs_to    :product_subcategory
  belongs_to    :allocation_strategy
  belongs_to    :customer
  belongs_to	:customer_type
  
  validates	:warehouse_id, :order_sequence, :allocation_strategy_id, :presence => true


  def match_criteria
    @allocation_strategy_criteria = self.attributes.clone
    @allocation_strategy_criteria.delete("id")
    @allocation_strategy_criteria.delete("warehouse_id")
    @allocation_strategy_criteria.delete("order_sequence")
    @allocation_strategy_criteria.delete("created_at")
    @allocation_strategy_criteria.delete("updated_at")
    @allocation_strategy_criteria.delete_if {|k,v| v.blank?}
  end

end
