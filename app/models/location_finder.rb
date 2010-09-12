require 'singleton'
class LocationFinder
  include singleton

  attr_accessor :container

  def locate(*args)
  end

  def get_matching_storage_strategy
  end

  def evaluate_locations(storage_zone, *args)
  end

  def get_next_container
    @location_finder_queue = LocationFinderQueue.new
    self.container = @location_finder_queue.pop_container
  end

end
