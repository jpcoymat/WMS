class AddStrategyIdStratLine < ActiveRecord::Migration

  def self.up
    add_column  :allocation_strategy_lines, :allocation_strategy_id, :integer, :null => false
  end

  def self.down
  end
end
