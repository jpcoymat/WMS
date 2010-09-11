class PurchaseOrderLine < ActiveRecord::Base

  validates 	:line_number, :purchase_order_id, :product_id, :quantity, :presence => true
  validates 	:line_number, :scope => :purchase_order_id, :uniqueness => true
 
  validates 	:quantity, :numericality => {:greater_than_or_equal_to => 1}
 
  belongs_to    :purchase_order
  belongs_to    :product
  belongs_to    :product_status

  has_many      :receipt_lines, :as => :purchase_order_object


  
  def received_quantity
    @receivied_quantity = 0
    self.receipt_lines.each do |receipt_line|
      @received_quantity += receipt_line.quantity
    end
    @received_quantity
  end

  
end
