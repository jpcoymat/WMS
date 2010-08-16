class ProductLocationAssignment < ActiveRecord::Base

  belongs_to                :product
  belongs_to                :location
  belongs_to                :warehouse
  belongs_to                :allocation_strategy

  validates_presence_of     :product_id, :location_id, :replenishment_at, :maximum_quantity, :warehouse_id, :replenish_to, :allocation_strategy_id
  validates_uniqueness_of   :product_id, :scope => :location_id

  def deleteable?
    true
  end


end
