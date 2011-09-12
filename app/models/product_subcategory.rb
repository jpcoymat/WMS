class ProductSubcategory < ActiveRecord::Base

  validates	:name, :description, :product_category, :company_id, presence: true
  validates	:name, uniqueness: true

  belongs_to    :company
  belongs_to    :product_category

  has_many      :products
  has_many      :storage_strategy_rules
  
  def deleteable?
    if self.products and self.storage_strategy_rules
      true
    else
      false
    end
  end
  


end
