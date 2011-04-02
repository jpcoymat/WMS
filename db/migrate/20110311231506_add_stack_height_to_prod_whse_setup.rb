class AddStackHeightToProdWhseSetup < ActiveRecord::Migration
  def self.up
	add_column :product_warehouse_setups, :stack_height, :integer
  end

  def self.down
  end
end
