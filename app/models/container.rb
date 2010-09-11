class Container < ActiveRecord::Base

  belongs_to	:container_location,  :polymorphic => true
  belongs_to 	:container_type
  
  acts_as_tree :foreign_key => 'parent_container_id'
  
  validates	:lp, :uniqueness => true
  validates	:lp, :container_location, :presence => true
  
  


end
