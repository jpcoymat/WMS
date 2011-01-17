class PurchaseOrderLine < ActiveRecord::Base

  include AASM
  
  aasm_column :state
  aasm_inital_state :created
  aasm_state  :created
  aasm_state  :receiving_started
  aasm_state  :closed

  validates 	:line_number, :purchase_order_id, :product_id, :quantity, :presence => true
  
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


  def editable?
	self.purchase_order.editable?
  end
  
end
