class CompanyIdReceiptTypes < ActiveRecord::Migration

  def self.up
    add_column  :receipt_types, :company_id,  :integer, :null => false
  end

  def self.down
  end
end
