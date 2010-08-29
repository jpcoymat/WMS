class AllocationStrategyRule < ActiveRecord::Base

  belongs_to      :warehouse
  belongs_to      :order_type
  belongs_to      :product_category
  belongs_to      :product_subcategory
  belongs_to      :allocation_strategy
  belongs_to      :customer
  belongs_to      :customer_type
  
  validates_presence_of   :warehouse_id, :order_sequence, :allocation_strategy_id


end
