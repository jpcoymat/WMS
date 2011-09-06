class Assignment < ActiveRecord::Base

	has_many 	  :assignment_details, :dependent => :destroy
	belongs_to	:warehouse
	
	validates 	:type, :presence => true
	
	include AASM
  
  aasm_column         :state
  aasm_state          :created
  aasm_initial_state  :created
  aasm_state          :released
  aasm_state          :in_process
  aasm_state          :completed
  aasm_state          :canceled
  
  
  aasm_event :release do
    transitions :to => :released, :from => [:created]
  end
  
  aasm_event :start_processing do
    transitions :to => :in_process, :from => [:created, :released] 
  end
  
  aasm_event :cancel do
    transitions :to => :canceled, :from => [:created, :released]
  end
  
  aasm_event :complete do
    transitions :to => :completed, :from => [:created, :released, :in_process]
  end
  
end
