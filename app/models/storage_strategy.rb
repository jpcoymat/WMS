class StorageStrategy < ActiveRecord::Base
  
  belongs_to  	:warehouse
  has_many    	:storage_strategy_lines, :dependent => :destroy, :order => :order_sequence
  
  has_many    	:storage_strategy_rules
  has_many    	:product_warehouse_setups
  
  validates	:warehouse_id, :code, :presence => true
  
  def deleteable?
    self.storage_strategy_rules.empty? and self.product_warehouse_setups.empty?
  end
  

end
