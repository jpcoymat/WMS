class DockDoor < ActiveRecord::Base

	belongs_to	:warehouse
	validates	:name, :direction, :warehouse_id, presence: true
	validates	:name, uniqueness: true
	
	has_many    :containers,          as: :container_location
  has_many    :assignment_details,  as: :from_location
  has_many    :assignment_details,  as: :end_location
  


  def self.directions
    ["Inbound", "Outbound", "Both"]
  end

end
