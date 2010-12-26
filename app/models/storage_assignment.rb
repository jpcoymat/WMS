class StorageAssignment < Assignment

	validates :to_location_id, :from_location_id, :from_container_id, :presence => true
	
	
	
	
end
