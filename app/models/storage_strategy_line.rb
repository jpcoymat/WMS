class StorageStrategyLine < ActiveRecord::Base
  
  belongs_to    :storage_strategy
  belongs_to    :storage_zone
  validates	    :order_sequence, :storage_zone_id, :storage_strategy_id, :presence => true
  validates   	:order_sequence, :uniqueness => true

  def check_criteria 
    @check_criteria = self.attributes.clone
    @check_criteria.delete_if  {|k,v| !(k.include?("check"))}
    @check_criteria
  end


end
