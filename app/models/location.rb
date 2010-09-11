class Location < ActiveRecord::Base

  before_create         :name

  validates		:name,  :warehouse_id,  :location_type_id, :presence => true
  validates		:name,  :scope => :warehouse_id, :uniqueness => true
  
  has_many    :containers
  has_many    :product_location_assignments
  has_many    :assignment_details
  belongs_to  :warehouse
  belongs_to  :location_type
  belongs_to  :storage_zone
  belongs_to  :allocation_zone


  def name
    @name = ""
    for i in (1 .. self.location_type.components.count)
      if self.location_type.attributes[ self.location_type.components[i]]
        @name += self.attributes[self.location_type.components[i]]
        unless self.location_type.lowest_component ==  self.location_type.components[i]
          @name += "-"
        end
      end
    end
    self.name = @name
  end

  def volume
    @volume = self.location_type.volume 
  end
  
  
  

end
