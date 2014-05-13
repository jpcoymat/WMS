class RemoveReceiptStuff < ActiveRecord::Migration
  def up
    drop_table :receipt_lines
    drop_table :receipt_types
    drop_table :receipts
    remove_column :storage_strategy_rules, :receipt_type_id


  end

  def down
  end
end
