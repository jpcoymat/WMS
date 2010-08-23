class PurchaseOrder < ActiveRecord::Base

  validates_presence_of   :purchase_order_number, :company_id
  validates_uniqueness_of :purchase_order_number, :scope => :company_id
  
  belongs_to              :supplier
  belongs_to              :purchase_order_type

  has_many                :purchase_order_lines
  
  #needs to be updated upon determining PO Line - Receipt - Receipt Line - Container relationship
  def editable?
    return true
  end

end
