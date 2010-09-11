class ProductPackage < ActiveRecord::Base

  belongs_to 	:product
  belongs_to 	:uom

  validates 	:product_id, :length, :width, :height, :quantity, :uom_id, :presence => true
  validates 	:uom_id, :scope => :product_id, :uniqueness => true


  def volume
    @volume = self.length * self.width * self.height
  end
  

end
