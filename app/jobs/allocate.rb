class Allocate
  
  @queue = :allocate
  
  def perform(wave_number)
    @wave = Wave.find(wave_id)
    unless @wave.nil?
      @order_lines = OrderLine.where(:wave_id => @wave.id).order(:item_id)
    else
        
    end
  end
  
end