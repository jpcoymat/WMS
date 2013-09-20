class AddCompanyIdProdStat < ActiveRecord::Migration

  def self.up
    add_column  :product_statuses, :company_id, :integer, :null => false
  end

  def self.down
  end
end
