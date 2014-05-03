class ProductSubcategory < ActiveRecord::Base

  roomer :tenanted

  validates	:name, :description, :product_category, :company_id, presence: true
  validates	:name, uniqueness: {scope: :product_category_id}

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
