class ReceiptLinePoRelationship < ActiveRecord::Migration

  def self.up
    remove_column :receipts, :purchase_order_id
    add_column    :receipt_lines, :purchase_order_object_type, :string, :limit => 100
    add_column    :receipt_lines, :purchase_order_object_id,  :integer
  end

  def self.down
  end
end
