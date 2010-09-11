class ProductLocationAssignment < ActiveRecord::Base

  belongs_to    :product
  belongs_to    :location
  belongs_to    :warehouse
  belongs_to    :allocation_strategy

  validates	:product_id, :location_id, :replenishment_at, :maximum_quantity, :warehouse_id, :replenish_to, :allocation_strategy_id, :presence => true


  def deleteable?
    true
  end


end
