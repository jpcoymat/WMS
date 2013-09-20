class LotProductStatusItem < ActiveRecord::Migration

  def self.up
	add_column :products, :product_status_id, :integer, :null => false
	add_column :products, :lot_management_type, :string, :limit => 25, :null => false
  end

  def self.down
  end
end
