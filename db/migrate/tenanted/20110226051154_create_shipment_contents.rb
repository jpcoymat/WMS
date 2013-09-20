class CreateShipmentContents < ActiveRecord::Migration
  def self.up
    create_table :shipment_contents do |t|
      t.integer :shipment_id, :null => false
      t.references :content, :polymorphic => true
      t.timestamps
    end
  end

  def self.down
    drop_table :shipment_contents
  end
end
