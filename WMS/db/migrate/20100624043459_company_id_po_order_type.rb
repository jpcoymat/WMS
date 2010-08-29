class CompanyIdPoOrderType < ActiveRecord::Migration

  def self.up
    add_column  :order_types,           :company_id,  :integer,   :null => false
    add_column  :purchase_order_types,  :company_id,  :integer,   :null => false
  end

  def self.down
  end
end
