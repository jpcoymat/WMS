class Order < ActiveRecord::Base


  include AASM
  
  aasm_column :state
  aasm_initial_state :created
  aasm_state  :created
  aasm_state  :allocated
  aasm_state  :picked
  aasm_state  :staged
  aasm_state  :loaded
  aasm_state  :shipped  
  aasm_state  :cancelled
  
  
  aasm_event :allocate do
    transitions :to => :allocated, :from => [:created]
  end

  aasm_event :pick do
    transitions :to => :picked, :from => [:allocated]
  end  

  aasm_event :stage do
    transitions :to => :staged, :from => [:picked]
  end
  
  aasm_event :load do
    transitions :to => :loaded, :from => [:staged]
  end
  
  aasm_event :ship do
    transitions :to => :loaded, :from => [:shipped]
  end
  
  aasm_event :cancel do
    transitions :to => :cancelled, :from => [:created]
  end
  

  validates	:order_number, :ship_date, :customer_id, :received_date, :ship_addres_1, :ship_city, :ship_country_id, :company_id, :presence => true
  validates	:order_number, :uniqueness => true

  belongs_to	:company
  belongs_to	:customer
  belongs_to	:order_type
  
  has_many	:order_lines  

  has_many	:shipment_contents, :as => :content


  def ship_country
    @ship_country = Country.find(self.ship_country_id)
  end

end
