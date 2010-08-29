class PoLineProdPack < ActiveRecord::Migration

  def self.up
	rename_column :purchase_order_lines, :uom_id, :product_package_id
  end

  def self.down
  end
end
