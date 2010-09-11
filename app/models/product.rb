
class Product < ActiveRecord::Base

  belongs_to    :company
  belongs_to    :supplier
  belongs_to    :product_category
  belongs_to    :product_subcategory
  belongs_to    :allocation_strategy
  belongs_to    :storage_strategy
  
  has_many      :product_packages, :order => :quantity
  has_many      :product_warehouse_setups
  has_many      :product_location_assignments
  
  validates	:name, :barcode,  :company_id, :presence => true
  validates     :name, :uniqueness => true
  

  def health_check
    logical_each    =  ProductPackage.first(:conditions => ["product_id = #{self.id} and logical_each = true"])
    logical_case    =  ProductPackage.first(:conditions => ["product_id = #{self.id} and logical_case = true"])
    logical_pallet  =  ProductPackage.first(:conditions => ["product_id = #{self.id} and logical_pallet = true"])
    if logical_each and logical_case and logical_pallet
      true
    else
      false
    end
  end

end
