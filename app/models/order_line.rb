class OrderLine < ActiveRecord::Base

  before_create :find_allocation_strategy

  validates :line_sequence_number, :product_id, :quantity_ordered, :order_id, :presence => true
  validates :line_sequence_number, :uniqueness => true
  validates :lot_id, :lot_match => true
  validates :quantity_ordered, :numericality => {:greater_than => 0}

  belongs_to	:order
  belongs_to	:product
  belongs_to	:lot
  belongs_to	:product_status

  def allocation_strategy_match_attributes
    @allocation_strategy_match_attributes = {}
    order_type = self.order.order_type
    product_category = self.product.product_category
    product_subcategory = self.product.product_subcategory
    customer = order.customer
    customer_type = customer.customer_type if customer
    product_
  end
  
  def match_allocation_rule?(allocation_strategy_rule)
    rule_match = true
    allocation_strategy_rule.match_criteria.each do |k,v|
      unless v == self.allocation_strategy_match_attributes[k]
        rule_match = false
        break
      end
    end
    rule_match
  end

  def find_allocation_strategy
    @allocation_strategy = nil
    index = 0
    allocation_strategy_rules = AllocationStrategyRules.where(:warehouse_id => self.order.warehouse_id).order(:order_sequence).all
    while @allocation_strategy.nil? and index < allocation_strategy_rules.count
      allocation_strategy_rule = allocation_strategy_rules.allocation_strategy_rule
      if match_allocation_rule?(allocation_strategy_rule)
        @allocation_strategy = allocation_strategy_rule.allocation_strategy
        
      end
      index += 1
    end    
  end
  
  def product_name=(product_name)
    @product = Product.where(:name => product_name).first 
  end
  
  def lot_name=(lot_name)
    @lot = Lot.where(:name => lot_name).first
  end 
  
  def product_status_code=(product_status_code)
    @product_status = ProductStatus.where(:code => product_status_code)
  end

end
