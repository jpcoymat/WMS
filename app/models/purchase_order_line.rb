class PurchaseOrderLine < ActiveRecord::Base

  roomer :tenanted

  include AASM
  
  aasm_column :state

  aasm_initial_state :created
  aasm_state :canceled
  aasm_state :created
  aasm_state :in_receiving
  aasm_state :completed

  aasm_event :start_receiving do
    transitions :to => :in_receiving, :from => [:created]
  end

  aasm_event :complete_receiving do
    transitions :to => :completed, :from => [:created,:in_receiving]
  end

  aasm_event :cancel do
    transitions :to => :canceled, :from => [:created]
  end


  validates 	:line_number, :purchase_order_id, :product_id, :quantity, presence: true
  validates 	:quantity, :numericality => {:greater_than_or_equal_to => 1}
 
  validates_uniqueness_of :line_number, :scope => :purchase_order_id, :message => "PO Line already exists"

  belongs_to    :purchase_order
  belongs_to    :product
  belongs_to    :product_status

  has_many      :receipt_lines


  
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
  
  def deleteable?
	  self.purchase_order.created?
  end
  
  def as_json(options={})
    super(:include => :product)
  end
  

end
