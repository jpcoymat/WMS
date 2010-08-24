class ReceiptLine < ActiveRecord::Base

  validates_presence_of   :receipt_id, :lp, :product_id, :product_package_id, :lot_id, :quantity
  validates_uniqueness_of :lp

  belongs_to              :receipt
  belongs_to              :product
  belongs_to              :product_package
  belongs_to              :lot
  belongs_to              :purchase_order_object, :polymorphic =>true

end
