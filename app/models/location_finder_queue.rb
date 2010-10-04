require 'singleton'

class LocationFinderQueue
  include Singleton

  attr_accessor :containers

  def add_container(container)
    @location_finder = LocationFinder.instance
    if @location_finder.container.nil?
      @location_finder.container = container
    else
      self.containers.push container
    end 
  end

  def containers
    @containers ||= []
  end

  def get_next_container
    unless self.containers.first.nil? 
      @container = self.containers.first
	    self.containers.delete_at(0)
      return @container
    else
      return nil	
    end  
  end

end
