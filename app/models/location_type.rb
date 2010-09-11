class LocationType < ActiveRecord::Base
  
  validates	:code,  :name,  :length, :width, :height, :presence => true
  

  belongs_to    :warehouse
  has_many	:locations  

  
  def components
    @components = { 1 => "zone", 2 => "aisle", 3 => "bay", 4 => "level", 5 => "position" }
  end

  def active_components_array
    @active_components_array = []
    active_components.each_value {|value| @active_components_array << value }
    @active_components_array
  end


  def active_components
    @active_components = {}
    for i in (1 .. self.components.length)
      if self.attributes[self.components[i]]
        @active_components[i] = self.components[i]
      end
    end
    @active_components
  end

  def volume
    @volume = self.height*self.length*self.width
  end
  
  def lowest_component
    @lowest_component = ""
    for i in (1 .. self.components.count)
      if self.attributes[self.components[i]]
        @lowest_component = self.components[i]
      end    
    end
    @lowest_component
  end  
    
  def topmost_component
    @topmost_component = ""
    for i in (1 .. self.components.count)
      if self.attributes[self.components[i]]
        @topmost_component = self.components[i]
        break 
      end    
    end
    @topmost_component
  end
  
  def location_range_valid?(location_range)
    location_range_valid = true
    for i in ( 1 .. self.components.count)
      if self.attributes[self.components[i]]
        from_component = "from_" + self.components[i]
        to_component = "to_" + self.components[i]
        unless location_range.has_key?(from_component) and location_range.has_key?(to_component)
          unless location_range[from_component] <= location_range[from_component] 
            location_range_valid = false
          end
        end
      end
    end
    return location_range_valid
  end
  

end
