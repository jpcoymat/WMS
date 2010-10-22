class ContainerContent < ActiveRecord::Base

  belongs_to    :container
  belongs_to    :product
  belongs_to    :lot
  belongs_to    :product_status
  belongs_to    :receipt_line
  belongs_to    :order_line
  
  validates :quantity, :container_id, :product_id, :presence => true 
  validates :quantity, :numericality => {:greater_than_or_equal_to => 1}


  def attributes_match?(content_attributes)
    attributes_match =true
    content_attributes.delete_if {|k,v| v.blank?}
    content_attributes.each do |k,v| 
       if self.attributes[k] != v
        attributes_match = false
      end
    end
    return attributes_match
  end

  def product_package
    @product_package = nil
    self.product.product_packages.each do |product_package| 
      if self.quantity % product_package.quantity == 0
        @product_package = product_package
        break
      end
    end
    @product_package
  end
  
  def uom
    @uom = @product_package.uom unless @product_package.nil?
  end

  def uom_quantity
    @product_package = product_package
    @uom_quantity = (self.quantity/@product_package.quantity).ceil
    @uom_quantity
  end


end
