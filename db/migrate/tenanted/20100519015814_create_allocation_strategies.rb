class CreateAllocationStrategies < ActiveRecord::Migration
  def self.up
    create_table :allocation_strategies do |t|
      t.string :name,           :null => false, :limit => 25
      t.string :code,           :null => false, :limit => 5
      t.string :description,                    :limit => 50
      t.integer :warehouse_id,  :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :allocation_strategies
  end
end
