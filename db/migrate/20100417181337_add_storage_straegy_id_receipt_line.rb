class AddStorageStraegyIdReceiptLine < ActiveRecord::Migration

  def self.up
    add_column :receipt_lines, :strorage_strategy_id, :integer 
  end

  def self.down
  end
end
