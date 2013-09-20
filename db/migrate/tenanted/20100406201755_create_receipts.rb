class CreateReceipts < ActiveRecord::Migration
  def self.up
    create_table :receipts do |t|
      t.integer :supplier_id, :null => false
      t.date :estimated_receipt_date
      t.date :real_receipt_date, :null => false
      t.integer :receipt_type_id
      t.integer :company_id, :null => false
      t.string :receipt_number, :null => false, :limit => 50
      t.date :ship_date

      t.timestamps
    end
  end

  def self.down
    drop_table :receipts
  end
end
