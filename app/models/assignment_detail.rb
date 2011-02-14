class AssignmentDetail < ActiveRecord::Base

	belongs_to  :assignment
	validates   :assignment_id, :presence => true
	
	belongs_to  :from_location, :polymorphic => true
	belongs_to  :end_location,  :polymorphic => true


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
