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

  def single_product?
    @single_product = true 
    if self.container_contents.count == 1 and self.children.empty?
      return @single_product 
    elsif children.empty?
      @product = self.container_contents.first.product
      self.container_contents.each do |container_content|
      	if @product == container_content.product
          nil
        else
          @single_product = false
          break
        end
      end
      return @single_product
    else
      products = []
      self.container_contents.each do |container_content|
      	 products.include? container_content.product ? nil : products << container_content.product
      end
      if products.count == 1
      	self.children.each do |child_container|
      	  child_container.container_contents.each do |container_content|
      	    products.include? container_content.product ? nil : products << container_content.product
      	  end
      	end
      	products.count == 1 ? @single_product = true : @single_product = false
      else
      	@single_product = false
      end
      return @single_product
    end
  end

  def receipt_type 
    @receipt_type = nil	
    if self.container_contents.count == 1 and children.empty?
      @receipt_type = self.receipt_line.receipt.receipt_type 
    elsif children.empty?
      @receipt_type = self.receipt_line.receipt.receipt_type
      self.container_contents.each do |container_content|   
        container_content.receipt.receipt_type == @receipt_type ? @receipt_type = nil : nil
      end
    end	
    @receipt_type
  end
 
  def product_category
    @product_category = nil
    if single_product?
      @product_category = self.container_contents.first.product.product_category
    end	
    @product_category
  end
 
  def product_subcategory
    @product_subcategory = nil
    if single_product?
      @product_subcategory = self.container_contents.first.product.product_subcategory
    end
    @product_subcategory
  end


  def storage_attributes
    @storage_attributes = {}
    @storage_attributes[:receipt_type_id] = @receipt_type.id
    @storage_attributes[:product_category_id] = @product_category.id
    @storage_attributes[:product_subcategory_id] = @product_subcategory.id 
    uom ? @storage_attributes[:uom_id] = @uom.id : nil
    

      
  end

  def total_quantity(*args)
    args[:product].nil? ? product = nil : product = Product.find(args[:product])
    args[:product_status].nil? ? product_status = nil : product_status = ProductStatus.find(args[:product_status])
    args[:lot].nil? ? lot = nil : lot = Lot.find(args[:lot])
    @total_quantity = 0    
    unless self.container_contents.empty?
      self.container_contents.each do |container_content|
	@total += container_content.quantity
      end
    end
    unless self.children.empty?
      self.children.each do |child_container|
        @total += child_container.total_quantity :product_id => product, :product_status => product, :lot => lot
      end
    end
    @total_quantity
  end
  
  def supplier
    @supplier = nil
    unless self.receipt_line.nil?
       @supplier = self.receipt_line.receipt.supplier	    
    end
    @supplier
  end


  def uom
    @uom = nil
    container_quantity = total_quatity
    if @single_product
      product_packages = self.contaner_contents.first.product.product_packages
      product_packages.each do |product_package|
        if container_quantity >= product_package.quantity 
          @uom = product_package.uom
          break
        end
      end
    end
    @uom
  end 

end
