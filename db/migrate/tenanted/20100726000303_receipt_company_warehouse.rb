class ReceiptCompanyWarehouse < ActiveRecord::Migration

  def self.up
	rename_column	:receipts, :company_id, :warehouse_id
  end

  def self.down
  end
end
