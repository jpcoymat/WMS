class ProductWarehouseSetup < ActiveRecord::Base

  belongs_to  :product
  belongs_to  :warehouse
  belongs_to  :product_status
  belongs_to  :allocation_strategy
  belongs_to  :storage_strategy
  
  validates_presence_of   :product_id,  :warehouse_id,  :product_status_id
  validates_uniqueness_of :product_id,  :scope => :warehouse_id


end
