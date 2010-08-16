class ContainerType < ActiveRecord::Base

  has_many  :containers
  
  validates_presence_of   :length, :width, :height, :maximum_weight, :purpose
  
  
  def volume
    @volume = self.length*self.width*self.height
  end

end
