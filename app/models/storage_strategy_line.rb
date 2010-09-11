class StorageStrategyLine < ActiveRecord::Base
  
  belongs_to    :storage_strategy
  belongs_to    :storage_zone
  validates	:order_sequence, :storage_zone_id, :storage_strategy_id, :presence => true
  validates   	:order_sequence, :scope => storage_zone_id, :uniqueness => true

end
