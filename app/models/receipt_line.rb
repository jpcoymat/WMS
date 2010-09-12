class ReceiptLine < ActiveRecord::Base

  validates	:receipt_id, :lp, :product_id, :product_package_id, :lot_id, :quantity, :presence => true
  validates	:lp, :uniqueness => true
  validates	:quantity, :numericality => {:greater_than_or_equal_to => 1}

  belongs_to    :receipt
  belongs_to    :product
  belongs_to    :product_package
  belongs_to    :lot
  belongs_to    :purchase_order_object, :polymorphic =>true

end
