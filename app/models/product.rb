
class Product < ActiveRecord::Base

  roomer :tenanted

  belongs_to    :company
  belongs_to    :supplier
  belongs_to    :product_category
  belongs_to    :product_subcategory
  belongs_to    :allocation_strategy
  belongs_to    :storage_strategy
  
  has_many      :product_packages, order: 'quantity DESC'
  has_many      :product_warehouse_setups
  has_many      :product_location_assignments
  has_many      :lots
  
  validates	    :name, :barcode,  :company_id, presence: true
  validates     :name, uniqueness: true
  validates     :product_subcategory_id, product_category_match: true
  

  def health_check

    logical_each    =  ProductPackage.where(product_id: self.id, logical_each: true).all
    logical_case    =  ProductPackage.where(product_id: self.id, logical_case: true).all
    logical_pallet  =  ProductPackage.where(product_id: self.id, logical_pallet: true).all
    if logical_each.count ==1 and logical_case.count == 1  and logical_pallet.count == 1
      true
    else
      false
    end
  end

end
