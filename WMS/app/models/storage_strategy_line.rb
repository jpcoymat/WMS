class StorageStrategyLine < ActiveRecord::Base
  
  belongs_to              :storage_strategy
  belongs_to              :storage_zone
  validates_presence_of   :order_sequence, :storage_zone_id, :storage_strategy_id

end
