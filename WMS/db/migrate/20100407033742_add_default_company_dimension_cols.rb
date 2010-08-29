class AddDefaultCompanyDimensionCols < ActiveRecord::Migration
  def self.up
	add_column :companies, :default_quantity_uom_id, :integer
	add_column :companies, :default_length_uom_id, :integer
	add_column :companies, :default_weight_uom_id, :integer
  end

  def self.down
  end
end
