class Lot < ActiveRecord::Base

  belongs_to  :product
  belongs_to  :product_status
  validates :product_id, :fifo_date, :product_status_id, :name, :presence => true
  validates :name, :uniqueness => true 
  
  
  before_create :set_name
  
  def self.all_lot_types
    ["Daily", "Weekly", "Monthly", "Bi-monthly", "Quarterly", "Semi-annual", "Annual"]
  end

  def set_name
    unless self.name
      self.name = self.fifo_date.strftime("%Y-%m-%d")
    end
  end



end
