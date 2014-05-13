class Supplier < ActiveRecord::Base

  roomer :tenanted

  validates	:name, :address_1, :city, :country_id, :company_id, presence: true
  validates	:name, uniqueness: true
  belongs_to    :country
  belongs_to    :company
  
  has_many      :products
  has_many      :purchase_orders
  has_many      :storage_strategy_rules
  
  def deleteable?
    if self.products.empty? and self.purchase_orders.empty? and self.storage_strategy_rules.empty?
      true
    else
      false
    end
  end


end
