class PurchaseOrder < ActiveRecord::Base

  validates	:purchase_order_number, :company_id, :presence => true
  validate	:purchase_order_number, :uniqueness => true
  
  belongs_to    :supplier
  belongs_to    :purchase_order_type
  belongs_to    :company

  has_many      :receipt_lines, :as => :purchase_order_object
  has_many      :purchase_order_lines
  
  acts_as_state_machine :initial => :created

  state :created
  state :receiving_started
  state :closed
  

  def editable?
    self.state == 'created'
  end

  def total_quantity
    ordered_quantity = 0
    self.purchase_order_lines.each do |purchase_order_line|
      ordered_quantity += purchase_order_line.quantity
    end
    ordered_quantity
  end
 
  def received_quantity
	@received_quantity = 0
	#first adding receipt lines against self
	self.receipt_lines.each do |receipt_line|
		@received_quantity += receipt_line.quantity	
	end
	@received_quantity
  end 

end
