class CreateLots < ActiveRecord::Migration
  def self.up
    create_table :lots do |t|
      t.integer :product_id, :null => false
      t.date :fifo_date, :null => false
      t.integer :product_status_id
      t.timestamps
    end
  end

  def self.down
    drop_table :lots
  end
end
