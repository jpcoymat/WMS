class PurchaseOrder < ActiveRecord::Base

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



  validates	:purchase_order_number, :company_id, presence: true
  validates	:purchase_order_number, uniqueness: true
  
  belongs_to    :supplier
  belongs_to    :purchase_order_type
  belongs_to    :company

  has_many      :purchase_order_lines
  

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
	  self.purchase_order_lines.each do |purchase_order_lines|
		  @received_quantity += purchase_order_lines.received_quantity	
	  end
	  @received_quantity
  end 

  def type_name
    purchase_order_type.try(:purchase_order_type)
  end

  def supplier_name
    supplier.try(:name)
  end

  
  def as_json(options={})
    super(include: {purchase_order_lines: {include: :product}}, methods: [:type_name, :supplier_name])
  end
  
  def containers
    @containers = []
    self.purchase_order_lines.each do |po_line|
      @containers << po_line.containers
    end
    @containers.flatten!
    @containers.uniq!
    @containers
  end
  
end
