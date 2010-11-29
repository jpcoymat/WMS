class Receipt < ActiveRecord::Base

  validates	:estimated_receipt_date, :warehouse_id, :receipt_number, :presence => true
  validates	:receipt_number, :uniqueness => true
  
  belongs_to    :warehouse
  belongs_to    :supplier
  
  has_many      :receipt_lines
  
  acts_as_state_machine :initial => :created

  state :created
  state :in_receiving
  state :completed
  state :cancelled

  event :start_receiving do
    transitions :from => :created, :to => :in_receiving
  end
  
  event :complete_receiving do
    transitions :from => :in_receiving, :to => :completed
    transitions :from => :created, :to => :completed
    transitions :from => :completed, :to => :completed
  end
  
  event :cancel do
    transitions :from => :created, :to => :cancelled
  end
  
  
  def total_quantity
    @total_quantity =  0
    self.receipt_lines.each do |receipt_line|
      @total_quantity += receipt_line.quantity
    end
    @total_quantity
  end
  
 
end
