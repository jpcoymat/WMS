class CreateProductSubcategories < ActiveRecord::Migration
  def self.up
    create_table :product_subcategories do |t|
      t.integer :product_category_id, :null => false
      t.string :name, :null => false, :limit => 25
      t.string :description, :null => false, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :product_subcategories
  end
end
