class OrderType < ActiveRecord::Base

  validates_presence_of     :order_type, :company_id
  validates_uniqueness_of   :order_type, :scope => :company_id
  
  belongs_to                :company
  has_many                  :orders
  has_many                  :allocation_strategy_rules
  
  def deleteable?
    self.orders.empty? and self.allocation_strategy_rules.empty?
  end


end
