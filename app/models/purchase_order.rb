class PurchaseOrder < ActiveRecord::Base

  validates_presence_of   :purchase_order_number, :company_id
  validates_uniqueness_of :purchase_order_number, :scope => :company_id
  
  belongs_to              :supplier
  belongs_to              :purchase_order_type


end
