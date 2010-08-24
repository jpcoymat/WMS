class PurchaseOrder < ActiveRecord::Base

  validates_presence_of   :purchase_order_number, :company_id
  validates_uniqueness_of :purchase_order_number, :scope => :company_id
  
  belongs_to              :supplier
  belongs_to              :purchase_order_type
  belongs_to              :company

  has_many                :receipt_lines, :as => :purchase_order_objects
  has_many                :purchase_order_lines
  
  def editable?
    @editable = true
    if self.receipt_lines.empty?
      self.purchase_order_lines.each do |purchase_order_line|
        if purchase_order_line.editable?
          @editable = false
          break
        end
      end
    else
      @editable = false
    end
    @editable
  end

  def total_quantity
    ordered_quantity = 0
    self.purchase_order_lines.each do |purchase_order_line|
      ordered_quantity += purchase_order_line.quantity
    end
    ordered_quantity
  end
  

end
