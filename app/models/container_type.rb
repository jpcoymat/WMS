class ContainerType < ActiveRecord::Base

  has_many  	:containers
  
  validates	:length, :width, :height, :maximum_weight, :purpose, :presence => true
  
  
  def volume
    @volume = self.length*self.width*self.height
  end

end
