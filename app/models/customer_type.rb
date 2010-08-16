class CustomerType < ActiveRecord::Base

  belongs_to              :company
  has_many                :customers
  has_many                :allocation_strategy_rules
  validates_presence_of   :company_id, :code
  validates_uniqueness_of :code, :scope => :company_id

  def deleteable?
    self.customers.empty? and self.allocation_strategy_rules.empty?    
  end


end
