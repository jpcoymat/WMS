class Locate

  @queue = :storage

  attr_accessor :container 

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
    @storage_assignment.assignment_details.create(:from_location_id => @container.container_location.id, :to_location_id => storage_location.id, :from_container => container.id)
    @storage_assignment.save!
    @storage_assingment
  end


  def get_matching_storage_strategy
	  @storage_strategy = nil
	  @storage_strategy_rules = @container.container_location.warehouse.storage_strategy_rules
	  index = 0
	  while @storage_strategy.nil? and index < @storage_strategy_rules.count
		  storage_strategy_rule = @storage_strategy_rules[index]
		  @storage_strategy = storage_strategy_rule.storage_strategy if storage_strategy_rule.match_for_container?(@container) 
	  end 
	  @storage_strategy
  end



  def find_location(storage_zone, *check_criteria)
    @storage_location = nil
    locations = Location.where(:warehouse_id => @container.container_location.warehouse.id, :storage_zone_id =>storage_zone.id, :available_for_storage => true).order(:storage_travel_sequence).all
    index = 0
    while @storage_location.nil? or index < locations.count
      location = locations[index]
      @storage_location = location if location.container_fits?(container)
      index+=1
    end
    @storage_location  
  end

end
