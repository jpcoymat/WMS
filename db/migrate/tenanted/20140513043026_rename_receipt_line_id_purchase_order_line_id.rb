class RenameReceiptLineIdPurchaseOrderLineId < ActiveRecord::Migration

  def up
    rename_column :container_contents, :receipt_line_id, :purchase_order_line_id 
  end

  def down
  end
end
