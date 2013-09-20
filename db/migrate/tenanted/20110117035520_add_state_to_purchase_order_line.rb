class AddStateToPurchaseOrderLine < ActiveRecord::Migration

  def self.up
    add_column  :purchase_order_lines,  :state, :string, :limit=> 20, :null => false
  end

  def self.down
  end
end
