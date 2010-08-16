class ProductPackage < ActiveRecord::Base

  belongs_to  :product
  belongs_to  :uom

  def volume
    @volume = self.length * self.width * self.height
  end
  

end
