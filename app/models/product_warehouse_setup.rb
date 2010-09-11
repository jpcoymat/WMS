class ProductWarehouseSetup < ActiveRecord::Base

  belongs_to  	:product
  belongs_to  	:warehouse
  belongs_to  	:product_status
  belongs_to 	:allocation_strategy
  belongs_to	:storage_strategy
  
  validates	:product_id,  :warehouse_id,  :product_status_id, :presence => true
  validates	:product_id,  :scope => :warehouse_id, :uniqueness => true


end
