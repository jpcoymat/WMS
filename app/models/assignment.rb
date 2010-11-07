class Assignment < ActiveRecord::Base

	has_many 	:assignment_details, :dependent => :destroy
	belongs_to	:warehouse
	
	validates 	:type, :presence => true

end
