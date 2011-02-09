class StorageStrategyRule < ActiveRecord::Base

  validates	:warehouse_id, :storage_strategy_id, :order_sequence_number, :presence => true
  validates	:order_sequence_number, :uniqueness => true
  
  belongs_to  :warehouse
  belongs_to  :product_category
  belongs_to  :product_subcategory
  belongs_to  :uom
  belongs_to  :supplier
  belongs_to  :product_status
  belongs_to  :purchase_order_type
  belongs_to  :receipt_type
  belongs_to  :storage_strategy

  def match?(container)
  	  match_criteria
  	  container.storage_attributes
  end
  
  def match_criteria
  	  @match_criteria = self.attributes
  	  @match_criteria.delete_if {|k,v| v.blank?}
	  @match_criteria.delete("created_at")
	  @match_criteria.delete("id")
	  @match_criteria.delete("storage_strategy_id")
	  @match_criteria.delete("updated_at")
  	  @match_criteria.delete("warehouse_id")
  	  @match_criteria.delete("storage_strategy")
  	  @match_criteria.delete("order_sequence_number")
  	  @match_criteria
  end
  
end
