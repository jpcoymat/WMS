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
  	  @products == 1
  end
  
  def products
  	  @products = []
  	  self.container_contents.each do |container_content|
  	  	  @products << container_content.product unless @products.include?(container_content.product)
  	  end
  	  children.each do |child_container|
  	  	  @products << child_container.products
  	  end
  	  @products.flatten!
  	  @products
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
    @storage_attributes[:supplier_id] = @supplier.id
      
  end

  def direct_quantity(criteria = {})
  	  @direct_quantity = 0
  	  self.container_contents.each do |container_content|
  	  	  container_content.attributes_match?(criteria) ? @direct_quantity += container_content.quantity : nil
  	  end
  	  @direct_quantity
  end
  
  
  def total_quantity(*args)
    args[:product].nil? ? product = nil : product = Product.find(args[:product])
    args[:product_status].nil? ? product_status = nil : product_status = ProductStatus.find(args[:product_status])
    args[:lot].nil? ? lot = nil : lot = Lot.find(args[:lot])
    @total_quantity = direct_quantity(args)	
    children.each do |container|
    	    @total_quantity += container.total_quantity(args)
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
  
  def product_status
  	  @product_status = nil
  	  if children.empty? and self.container_contents.count == 1
  	  	  @product_status = self.container_contents.first.product_status
  	  	  return @product_status
  	  elsif children.emtpy?
		  @product_status = self.container_contents.first.product_status	  	  
  	  	  self.container_contents.each do |container_content|
  	  	  	  @product_status == container_contents.product_status ? nil : @product_status = nil 
  	  	  end
  	  	  return @product_status
  	  else
  	  	  product_statuses = []
  	  	  self.container_contents.each do |container_content|
  	  	  	  product_statuses.include? container_content.product_status ? nil : product_statuses << container_content.product_status
  	  	  end
  	  	  unless product_statuses > 1
  	  	  	  children.each do |child_container|
  	  	  	  end
  	  	  end
  	  end
  	  
  end
  	 

end
