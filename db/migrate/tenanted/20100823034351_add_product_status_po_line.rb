class AddProductStatusPoLine < ActiveRecord::Migration

  def self.up
	add_column :purchase_order_lines, :product_status_id, :integer
  end

  def self.down
	remove_column :purchase_order_lines, :product_status_id
  end
end
