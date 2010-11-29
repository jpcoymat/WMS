class DockDoor < ActiveRecord::Base

	belongs_to	:warehouse
	validates	:name, :direction, :warehouse_id, :presence => true
	validates	:name, :uniqueness => true

  acts_as_state_machine :initial => :available
  
  state :available
  state :occupied
  
  
  event :occupy do
    transitions :from => :available, :to => :occupied
  end
  
  event :free do 
    transitions :from => :occupied, :to => :available
  end

  def self.directions
    ["Inbound", "Outbound", "Both"]
  end

end
