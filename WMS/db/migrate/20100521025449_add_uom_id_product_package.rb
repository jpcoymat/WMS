class AddUomIdProductPackage < ActiveRecord::Migration

  def self.up
	add_column	:product_packages, :uom_id, :integer, :null => false
  end

  def self.down
  end
end
