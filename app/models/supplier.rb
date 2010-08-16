class Supplier < ActiveRecord::Base

  validates_presence_of     :name, :address_1, :city, :country_id, :company_id
  validates_uniqueness_of   :name, :scope => :company_id
  belongs_to                :country
  belongs_to                :company
  
  has_many                :products
  has_many                :purchase_orders
  has_many                :receipts
  has_many                :storage_strategy_rules
  
  def deleteable?
    if self.products.empty? and self.purchase_orders.empty? and self.receipts.empty? and self.storage_strategy_rules.empty?
      true
    else
      false
    end
  end


end
