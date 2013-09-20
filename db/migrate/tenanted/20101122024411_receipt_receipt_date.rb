class ReceiptReceiptDate < ActiveRecord::Migration

  def self.up
    remove_column   :receipts,  :real_receipt_date
    add_column      :receipts,  :real_receipt_date, :date
  end

  def self.down
  end
end
