class ContainerContent < ActiveRecord::Base

  belongs_to    :container
  belongs_to    :product
  belongs_to    :lot
  belongs_to    :product_status
  belongs_to    :receipt_line
  belongs_to    :order_line
  
  validates	:quantity, :container_id, :product_id, :presence => true 
  validates     :quantity, :numericality => {:greater_than_or_equal_to => 1}

end
