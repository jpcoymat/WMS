class PurchaseOrder < ActiveRecord::Base

  validates_presence_of   :purchase_order_number, :company_id
  validates_uniqueness_of :purchase_order_number, :scope => :company_id
  
  belongs_to              :supplier
  belongs_to              :purchase_order_type
  belongs_to              :company

  has_many                :purchase_order_lines
  
  #needs to be updated upon determining PO Line - Receipt - Receipt Line - Container relationship
  def editable?
    return true
  end

  def total_quantity
    ordered_qty = 0
    self.purchase_order_lines.each do |purchase_order_line|
      ordered_qty += purchase_order_line.quantity
    end
    ordered_qty
  end

end
