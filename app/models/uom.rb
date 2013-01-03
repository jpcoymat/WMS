class Uom < ActiveRecord::Base

  validates_uniqueness_of	:code, scope: :company_id
  validates_uniqueness_of :name, scope: :company_id
  validates   	:type, :code, :name, :company_id, presence: true

  belongs_to 	:company
  
  has_many	:product_packages
  
  def self.types
    ["QuantityUom", "DimensionUom", "WeightUom", "VolumeUom"]
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
