class RenameStrategies < ActiveRecord::Migration

  def self.up
    rename_column :products,  :default_putaway_strategy_id,     :storage_strategy_id
    rename_column :products,  :default_allocation_strategy_id,  :allocation_strategy_id
  end

  def self.down
    rename_column :products,  :storage_strategy_id,     :default_putaway_strategy_id     
    rename_column :products,  :allocation_strategy_id,  :default_allocation_strategy_id
  end
end
