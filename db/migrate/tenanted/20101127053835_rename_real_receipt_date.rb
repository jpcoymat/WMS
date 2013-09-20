class RenameRealReceiptDate < ActiveRecord::Migration

  def self.up
    rename_column :receipts,:real_receipt_date, :received_at
  end

  def self.down
  end
end
