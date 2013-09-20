class CreateProductStatuses < ActiveRecord::Migration
  def self.up
    create_table :product_statuses do |t|
      t.string :code, :null => false, :limit => 5
      t.string :description, :limit => 50, :null => false
      t.boolean :allocatable, :null => false, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :product_statuses
  end
end
