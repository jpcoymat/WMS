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
  	  	  @products << container_content.product unless @products.include?(container_content.product) || container_content.product.nil?
  	  end
  	  children.each do |child_container|
  	  	  @products << child_container.products
  	  end
  	  @products.flatten!
  	  @products.uniq!
  	  @products
  end
  

  def receipt_types
    @receipt_types = []
    self.container_contents.each do |container_content|
      unless container_content.receipt_line.nil?
        @receipt_types << container_content.receipt_line.receipt.receipt_type unless @receipt_types.include?(container_content.receipt_line.receipt.receipt_type) 
      end
    end
    children.each do |child_container|
      @receipt_types << child_container.receipt_types
    end
    @receipt_types.flatten!
    @receipt_types.uniq!
    @receipt_types
  end
 
  def product_categories
    @product_categories = []
    self.container_contents.each do |container_content|
      @product_categories << container_content.product.product_category unless @product_categories.include?(container_content.product.product_category) || container_content.product.product_category.nil? 
    end
    children.each do |child_container|
      @product_categories << child_containe.product_categories
    end
    @product_categories.flatten!
    @product_categories.uniq!
    @product_categories
  end
 
  def product_subcategories
    @product_subcategories = []
    self.container_contents.each do |container_content|
      @product_subcategories << container_content.product.product_category unless @product_subcategories.include?(container_content.product.product_category) || container_content.product.product_category.nil? 
    end
    children.each do |child_container|
      @product_subcategories << child_containe.product_subcategories
    end
    @product_subcategories.flatten!
    @product_subcategories.uniq!
    @product_subcategories
  end


  def storage_attributes
    @storage_attributes = {}
    receipt_types.count ==1 ? @storage_attributes[:receipt_type_id] = @receipt_types.first.id : nil
    product_categories.count == 1 ? @storage_attributes[:product_category_id] = @product_categories.first.id : nil
    product_subcategories.coun == 1 ? @storage_attributes[:product_subcategory_id] = @product_subcategories.first.id : nil 
    uom ? @storage_attributes[:uom_id] = @uom.id : nil
    supplier ? @storage_attributes[:supplier_id] = supplier.id : nil
      
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
  
  def receipts
    @receipts = []
    self.container_contents.each do |container_content| 
      unless container_content.receipt_line.nil?
        @receipts << container_content.receipt_line.receipt unless @receipts.include?(container_content.receipt_line.receipt)
      end
    end
    children.each {|child_container| @receipts << child_container.receipts}
    @receipts.flatten!
    @receipts.uniq!
    @receipts
  end
  
  def supplier
    @supplier = nil
    @supplier = receipts.first.supplier if receipts.count == 1
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
