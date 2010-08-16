class AddAllocationStrategy < ActiveRecord::Migration

  def self.up
	add_column	:location_types,	:allocation_strategy_id,	:integer
  end

  def self.down
  end
end
