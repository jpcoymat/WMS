class AssignmentDetail < ActiveRecord::Base

	belongs_to :assignment
	validates :assignment_id, :presence => true

	def from_location
		@from_location = Location.first(self.from_location_id)
	end
	
	def to_location
		@to_location = Location.first(self.to_location_id)
	end

	def expected_product
		@expected_product = Product.first(self.expected_product_id)
	end
	
	def actual_product
		@actual_product = Product.first(self.actual_product_id)
	end
	
	def from_container
		@from_container = Container.first(self.from_container_id)
	end
	
	def to_container
		@to_container = Container.first(self.to_container_id)
	end
	
	

end
