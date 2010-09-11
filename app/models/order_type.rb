class OrderType < ActiveRecord::Base

  validates	:order_type, :company_id, :presence => true
  validates	:order_type, :scope => :company_id, :uniqueness => true
  
  belongs_to	:company
  has_many      :orders
  has_many      :allocation_strategy_rules
  
  def deleteable?
    self.orders.empty? and self.allocation_strategy_rules.empty?
  end


end
