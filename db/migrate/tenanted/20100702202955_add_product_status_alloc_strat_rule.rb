class AddProductStatusAllocStratRule < ActiveRecord::Migration

  def self.up
    add_column :allocation_strategy_rules, :product_status_id, :integer
  end

  def self.down
  end
end
