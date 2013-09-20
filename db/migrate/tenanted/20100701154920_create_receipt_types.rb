class CreateReceiptTypes < ActiveRecord::Migration
  def self.up
    create_table :receipt_types do |t|
      t.string :name,         :null => false,   :limit => 25
      t.string :code,         :null => false,   :limit => 50
      t.string :description,                    :limit => 100

      t.timestamps
    end
  end

  def self.down
    drop_table :receipt_types
  end
end
