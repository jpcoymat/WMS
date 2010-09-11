class OrderType < ActiveRecord::Base

  validates	:order_type, :company_id, :presence => true
  validates	:order_type, :uniqueness => true
  
  belongs_to	:company
  has_many      :orders
  has_many      :allocation_strategy_rules
  
  def deleteable?
    self.orders.empty? and self.allocation_strategy_rules.empty?
  end


end
