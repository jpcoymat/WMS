class CreateProductCategories < ActiveRecord::Migration
  def self.up
    create_table :product_categories do |t|
      t.string :name, :null => false, :limit => 25
      t.string :description, :null => false, :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :product_categories
  end
end
