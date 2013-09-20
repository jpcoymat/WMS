class AddState < ActiveRecord::Migration

  def self.up
	add_column :assignments, :state, :string, :limit => 50, :null => false
	add_column :shipments, :state, :string, :limit => 50, :null => false
	add_column :containers, :state, :string, :limit => 50, :null => false
	add_column :orders, :state, :string, :limit => 50, :null => false
	add_column :purchase_orders, :state, :string, :limit => 50, :null => false
  end

  def self.down
	drop_column :assignments, :state
	drop_column :shipments, :state  
	drop_column :containers, :state
	drop_column :orders, :state
	drop_column :purchase_orders, :state

  end
end
