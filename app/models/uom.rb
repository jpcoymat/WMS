class Uom < ActiveRecord::Base

  validates	:code, :scope => company_id, :uniqueness => true
  validates 	:name, :scope => company_id, :uniqueness => true
  validates   	:code, :name, :company_id
  
  has_many	:product_packages
  
  def self.types
    ["Quantity", "Dimension", "Weight", "Volume"]
  end
  
  def uom_type
    @uom_type = self.class.to_s
    @uom_type["Uom"] = ""
    @uom_type
  end

  def deleteable?
    if self.product_packages.empty?
      true
    else
      false
    end
  end

end
