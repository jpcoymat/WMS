class AllocStratRuleMoreFields < ActiveRecord::Migration

  def self.up
    add_column  :allocation_strategy_rules, :customer_id,         :integer
    add_column  :allocation_strategy_rules, :customer_type_id,    :integer
  end

  def self.down
  end
end
