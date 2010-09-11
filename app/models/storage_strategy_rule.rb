class StorageStrategyRule < ActiveRecord::Base

  validates	:warehouse_id, :storage_strategy_id, :order_sequence_number, :presence => true
  validates	:order_sequence_number, :scope => :warehouse_id, :uniqueness => true
  
  belongs_to  :warehouse
  belongs_to  :product_category
  belongs_to  :product_subcategory
  belongs_to  :uom
  belongs_to  :supplier
  belongs_to  :product_status
  belongs_to  :purchase_order_type
  belongs_to  :receipt_type
  belongs_to  :storage_strategy

end
