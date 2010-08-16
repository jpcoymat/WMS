class AddPurchaseOrderReceipt < ActiveRecord::Migration

  def self.up
	add_column :receipts, :purchase_order_id, :integer

  end

  def self.down
  end
end
