class ProductWarehouseSetup < ActiveRecord::Base

  belongs_to  	:product
  belongs_to  	:warehouse
  belongs_to  	:product_status
  belongs_to 	:allocation_strategy
  belongs_to	:storage_strategy
  
  validates	:product_id,  :warehouse_id,  :product_status_id, :presence => true
  validates	:product_id,  :uniqueness => true

  def find_or_create_lot
    fifo_date = get_fifo_date       
    lot = Lot.find(:first, :conditions => [:product_id => self.product_id, :fifo_date => fifo_date])
    unless lot
      lot = Lot.new(:product_id => self.product_id,:fifo_date => fifo_date, :product_status_id => self.product_status_id)
      lot.save!
    end
    lot
  end
  
  def get_fifo_date
    case self.lot_management_type
    when "Daily" 
      Time.now
    when "Weekly" 
      Time.now
    when "Monthly"
      Time.new(Time.now.year, Time.now.month,1)
    when "Bi-monthly" 
      if Time.now.month%2 >0
        Time.new(Time.now.year,Time.now.month,1)
      else
        Time.new(Time.now.year,Time.now.month-1,1)
      end            
    when "Semi-annual"  
      if Time.new.month > 6
        Time.new(Time.now.year,7,1)
      else
        Time.new(Time.now.year,1,1)
      end
    when "Annual" 
      Time.new(Time.now.year,1,1)
    end
  end


end
