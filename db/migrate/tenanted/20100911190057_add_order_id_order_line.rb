class AddOrderIdOrderLine < ActiveRecord::Migration
  def self.up
	add_column :order_lines, :order_id, :integer, :null => false
  end

  def self.down
  end
end
