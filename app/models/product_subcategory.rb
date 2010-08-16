class ProductSubcategory < ActiveRecord::Base

  validates_presence_of     :name, :description, :product_category, :company
  validates_uniqueness_of   :name
  belongs_to                :company
  belongs_to                :product_category
  has_many                  :products
  has_many                  :storage_strategy_rules
  
  def deleteable?
    if self.products and self.storage_strategy_rules
      true
    else
      false
    end
  end
  


end
