class Location < ActiveRecord::Base

  before_create         :name

  validates		:name,  :warehouse_id,  :location_type_id, :presence => true
  validates		:name,  :uniqueness => true
  
  has_many    :containers, :as => :container_location
  has_many    :product_location_assignments
  has_many    :assignment_details
  belongs_to  :warehouse
  belongs_to  :location_type
  belongs_to  :storage_zone
  belongs_to  :allocation_zone

  
  def pending_storage_assignments
  	  @pending_storage_assignments = AssignmentDetail.where(:to_location_id => self.id).all
  end

  def name
    @name = ""
    for i in (1 .. self.location_type.components.count)
      if self.location_type.attributes[ self.location_type.components[i]]
        @name += self.attributes[self.location_type.components[i]]
        @name += "-" unless self.location_type.lowest_component ==  self.location_type.components[i]
      end
    end
    self.name = @name
  end

  def volume
    @volume = self.location_type.volume 
  end
  
  def occupied_volume
    @occupied_volume = 0
    self.containers.each do |container|
      @occupied_volume += container.direct_weight
    end
    @occupied_volume
  end
  
  def occupied_weight
    @occupied_weight = 0
    self.containers.each do |container|
      @occupied_volume += container.direct_weight
    end
    @occupied_weight
  end
  
  def available_volume
    @available_volume = self.location_type.volume - occupied_volume
  end
  
  def available_weight
    @available_weight = self.location_type.maximum_weight - occupied_weight
  end
  
  def current_topmost_containers
    @current_topmost_containers = 0
    self.containers.each {|container| @current_topmost_containers += 1 if container.parent_container.nil?}
    @current_topmost_containers
  end
  
  def current_and_future_containers
  	  pending_storage_assignments.count + current_topmost_containers
  end
  
  def container_fits?(container)
    @container_fits = true
    if container.total_weight > available_weight || container.total_volume > available_volume || (self.location_type.maximum_containers <= current_and_future_containers || self.collapse_containers)
      @container_fits = false 
    end
    @container_fits
  end
  

end
