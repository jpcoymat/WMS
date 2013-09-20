class RemoveProductPackage < ActiveRecord::Migration

  def self.up
	remove_column 	:receipt_lines, :product_package_id
	remove_column	:order_lines, :product_package_id
	remove_column	:purchase_order_lines, :product_package_id
	rename_column	:purchase_order_lines, :quantity_uom, :quantity
  end

  def self.down
  end
end
