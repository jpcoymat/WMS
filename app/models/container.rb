class Container < ActiveRecord::Base

  belongs_to  :container_location,  :polymorphic => true
  belongs_to  :container_type
  
  acts_as_tree :foreign_key => 'parent_container_id'
  
  validates_uniqueness_of   :lp
  validates_presence_of     :lp,  :container_location
  
  


end
