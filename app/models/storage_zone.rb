class StorageZone < ActiveRecord::Base
  
  validates_presence_of   :warehouse_id, :code, :name
  validates_uniqueness_of :code, :scope => :warehouse_id
  
  has_many                :locations
  has_many                :storage_strategy_lines
  
  def deleteable?
    if self.locations.empty? and self.storage_strategy_lines.empty?
      true
    else
      false
    end
  end



end
