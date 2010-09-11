class StorageZone < ActiveRecord::Base
  
  validates	:warehouse_id, :code, :name, :presence => true
  validates	:code, :scope => :warehouse_id, :uniqueness => true
  
  has_many      :locations
  has_many      :storage_strategy_lines
  
  def deleteable?
    if self.locations.empty? and self.storage_strategy_lines.empty?
      true
    else
      false
    end
  end



end
