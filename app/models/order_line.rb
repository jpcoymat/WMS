class OrderLine < ActiveRecord::Base


  validates :line_sequence_number, :product_id, :quantity_ordered, :order_id, :presence => true
  validates :line_sequence_number, :uniqueness => true, :scope => :order_id

  validates :quantity_ordered, :numericality => {:greater_than => 0}

  belongs_to	:order
  belongs_to	:product
  belongs_to	:lot
  belongs_to	:product_status


end
