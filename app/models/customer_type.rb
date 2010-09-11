class CustomerType < ActiveRecord::Base

  belongs_to    :company
  has_many      :customers
  has_many      :allocation_strategy_rules
  validates   	:company_id, :code, :presence => true
  validates 	:code, :company_id, :uniqueness => true

  def deleteable?
    self.customers.empty? and self.allocation_strategy_rules.empty?    
  end


end
