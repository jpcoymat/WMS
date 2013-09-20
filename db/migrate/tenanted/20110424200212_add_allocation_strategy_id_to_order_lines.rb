class AddAllocationStrategyIdToOrderLines < ActiveRecord::Migration

  def self.up
    add_column  :order_lines, :allocation_strategy_id, :integer
  end

  def self.down
  end
end
