class Container < ActiveRecord::Base

  belongs_to	:container_location,  :polymorphic => true
  belongs_to 	:container_type
  has_many	:container_contents

  acts_as_tree :foreign_key => 'parent_container_id'

  acts_as_state_machine :initial => :created

  state :created
  state :received
  state :stored
  state :allocated
  state :picked
  state :staged
  state :loaded
  state :shipped  
  state :closed

  
  validates	:lp, :uniqueness => true
  validates	:lp, :container_location, :presence => true

  def singe_product?
    @single_product = true 
    if self.container_contents.count == 1
      return @single_product 
    else
      products = []
      products << self.container_contents.first.product_id
      self.container_contents.each do |container_content|
	if products.include? container_content.product
          nil
        else
          @single_product = false
          break
        end
      end
      return @single_product	
    end
  end

  def receipt_type 
    @receipt_type = nil	
    if self.container_contents.count == 1
      @receipt_type = self.receipt_line.receipt.receipt_type 
    else
      receipts = []
      receipts << self.container_contents.first.receipt_line.receipt.receipt_type
      
    end	
  end
  
  def storage_attributes
    @storage_attributes = {}
    if self.single_product?
      
  end

end
