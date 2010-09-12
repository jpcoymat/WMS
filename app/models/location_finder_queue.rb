require 'singleton'

class LocationFinderQueue
  include singleton

  attr_accesor :containers

  def push_container(container)
    @location_finder = LocationFinder.new
    if @location_finder.container.nil?
      @location_finder.container = container
    else
      self.containers.push container
    end 
  end

  def pop_container
    unless self.containers.last.nil? 
      @container = self.containers.pop
      return @container
    else
      return nil	
    end  
  end

end
