class RemoveOrderPriorityFromOrders < ActiveRecord::Migration
  def self.up
    remove_column :orders, :order_priority
  end

  def self.down
  end
end
