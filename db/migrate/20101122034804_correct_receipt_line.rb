class CorrectReceiptLine < ActiveRecord::Migration

  def self.up
      remove_column :receipt_lines, :purchase_order_object_type
      remove_column :receipt_lines, :purchase_order_object_id
      add_column    :receipt_lines, :purchase_order_line_id,  :integer
  end

  def self.down
  end
end
