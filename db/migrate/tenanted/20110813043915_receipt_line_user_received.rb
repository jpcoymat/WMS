class ReceiptLineUserReceived < ActiveRecord::Migration

  def self.up
    add_column  :receipt_lines, :received_by_user_id, :integer
  end

  def self.down
  end
end
