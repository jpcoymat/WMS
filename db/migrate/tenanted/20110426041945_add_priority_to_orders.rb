class AddPriorityToOrders < ActiveRecord::Migration

  def self.up
    add_column :orders, :priority, :integer
  end

  def self.down
    remove_column :orders, :priority
  end
end
