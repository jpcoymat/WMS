class ProductCategory < ActiveRecord::Base

  validates_uniqueness_of :name 
  validates_presence_of   :name, :description
  has_many                :product_subcategories
  has_many                :products
  has_many                :storage_strategy_rules
  

  def deleteable?
    if self.products and self.storage_strategy_rules
      true
    else
      false
    end
  end



end
