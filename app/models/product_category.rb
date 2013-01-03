class ProductCategory < ActiveRecord::Base

  validates	:name, uniqueness: true
  validates	:name, :description, :company_id, presence: true

  belongs_to	:company

  has_many      :product_subcategories
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
