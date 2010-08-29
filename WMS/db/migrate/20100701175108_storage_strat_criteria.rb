class StorageStratCriteria < ActiveRecord::Migration

  def self.up
    add_column  :storage_strategy_rules,  :purchase_order_type_id,  :integer
    add_column  :storage_strategy_rules,  :receipt_type_id,         :integer
  end

  def self.down
  end
end
