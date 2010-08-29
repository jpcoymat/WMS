class AddSkuBarcode < ActiveRecord::Migration
  def self.up
	add_column :products, :barcode, :string, :limit => 100
	add_column :products, :alias, :string, :limit => 100
  end

  def self.down
	remove_column :products, :barcode
	remove_column :products, :alias
  end
end
