class CreatePurchaseOrderTypes < ActiveRecord::Migration
  def self.up
    create_table :purchase_order_types do |t|
      t.string :purchase_order_type,  :limit => 25, :null => false
      t.string :description,          :limit => 50         

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_order_types
  end
end
