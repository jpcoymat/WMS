class Receipt < ActiveRecord::Base

  validates	:estimated_receipt_date, :warehouse_id, :receipt_number, :presence => true
  validates	:receipt_number, :uniqueness => true
  
  belongs_to    :warehouse
  belongs_to    :supplier
  
  has_many      :receipt_lines
  
  def total_quantity
    @total_quantity =  0
    self.receipt_lines.each do |receipt_line|
      @total_quantity += receipt_line.quantity
    end
    @total_quantity
  end


end
