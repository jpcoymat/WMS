class Receipt < ActiveRecord::Base
  
  include AASM
  
  aasm_column :state
  aasm_initial_state :created
  aasm_state :in_receiving
  aasm_state :completed
  aasm_state :cancelled


  validates	:estimated_receipt_date, :warehouse_id, :receipt_number, :presence => true
  validates	:receipt_number, :uniqueness => true
  
  belongs_to    :warehouse
  belongs_to    :supplier
  
  has_many      :receipt_lines
  

  aas_event :start_receiving do
    transitions :to => :in_receiving, :from => :created
  end
  
  aasm_event :complete_receiving do
    transitions :to => :completed, :from => [:created,:in_receiving] 
  end
  
  aasm_event :cancel do
    transitions :to => :cancelled, :from => :created
  end
  
  
  def total_quantity
    @total_quantity =  0
    self.receipt_lines.each do |receipt_line|
      @total_quantity += receipt_line.quantity
    end
    @total_quantity
  end
  
 
end
