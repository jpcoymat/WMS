class AddProductCategory < ActiveRecord::Migration
  def self.up
	add_column :products, :category_type, :string
	add_column :products, :category_id, :integer
  end

  def self.down
  end
end
