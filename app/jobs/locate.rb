class Locate

  @queue = :storage

  def perform(container)
    @container = Container.find(container)
    @warehouse = @container.container_location.warehouse 
    exclude_location = args[:exclude]
    storage_strategy = get_matching_storage_strategy
    if storage_strategy
      storage_location = nil
      index = 0
      while  storage_location.nil? && index < storage_strategy.storage_strategy_lines.count
        storage_strategy_line = storage_strategy.storage_strategy_lines[index]
        storage_location = find_location(storage_strategy_line.storage_zone, storage_strategy_line.check_criteria)
        index += 1
      end
      if storage_location
      	      @storage_assignment = create_storage_assignments(storage_location)
      end
    end
  end

  def create_storage_assignments(storage_location)
    @storage_assignment = StorageAssignment.new
    @storage_assignment.assignment_details.create(:from_location_id => container.container_location.id, :to_location_id => storage_location.id, :from_container => container.id)
    @storage_assignment.save!
    @storage_assingment
  end

  def get_matching_storage_strategy
        @storage_strategy = nil
  	@storage_strategy_rules = @warehouse.storage_strategy_rules
  	@storage_strategy_rules.each do |storage_strategy_rule|
	  rule_match = true
  	  storage_strategy_rule.match_criteria.each do |k,v|
  	    unless v == @container.storage_attributes[k]
  	      rule_match == false
  	      break
	    end
          end
	  if rule_match
	    @storage_strategy = storage_strategy_rule.storage_strategy
	    break
	  end
	end
	@storage_strategy
  end

  def get_next_container
    @location_finder_queue = LocationFinderQueue.new
    self.container = @location_finder_queue.get_next_container
    self.warehouse = self.container.warehouse
  end

  def find_location(storage_zone, *check_criteria)
    @storage_location = nil
    locations = Location.where(:warehouse_id => @warehouse.id, :storage_zone =>storage_zone.id, :available_for_storage => true).order(:storage_travel_sequence).all
    index = 0
    while @storage_location.nil? or index < locations.count
      location = locations[index]
      if location.container_fits?(container)
        @storeage_loation = location
      end
      index+=1
    end
    @storage_location  
  end

end
