class CreateProductPackages < ActiveRecord::Migration
  def self.up
    create_table :product_packages do |t|
      t.string :product_id, :null => false
      t.boolean :logical_each
      t.boolean :logical_case
      t.boolean :logical_pallet
      t.decimal :length, :null => false, :scale => 2, :precision => 8
      t.decimal :width, :null => false, :scale => 2, :precision => 8
      t.decimal :height, :null => false, :scale => 2, :precision => 8
      t.integer :quantity, :null => false
      t.boolean :active, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :product_packages
  end
end
