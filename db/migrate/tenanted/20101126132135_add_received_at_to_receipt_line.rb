class AddReceivedAtToReceiptLine < ActiveRecord::Migration

  def self.up
    add_column :receipt_lines, :received_at,:date
  end

  def self.down
  end
end
