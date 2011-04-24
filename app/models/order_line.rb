class OrderLine < ActiveRecord::Base

  after_create :find_allocation_strategy

  validates :line_sequence_number, :product_id, :quantity_ordered, :order_id, :presence => true
  validates :line_sequence_number, :uniqueness => true

  validates :quantity_ordered, :numericality => {:greater_than => 0}

  belongs_to	:order
  belongs_to	:product
  belongs_to	:lot
  belongs_to	:product_status

  def allocation_strategy_criteria
    order_type = self.order.order_type
    product_category = self.product.product_category
    product_subcategory = self.product.product_subcategory
    customer = order.customer
    customer_type = customer.customer_type if customer
    product_
  end
  
  def match_allocation_rule?(allocation_rule)
    rule_match = true
    while rule_match
      
    end
  end

  def find_allocation_strategy
    allocation_strategy_rules = AllocationStrategyRules.where(:warehouse_id => self.order.warehouse_id).order(:order_sequence)
    allocation_strategy_rules.each do |allocation_strategy_rule|
      if allocation_strategy_criteria
        
      end
    end
    
  end

end
