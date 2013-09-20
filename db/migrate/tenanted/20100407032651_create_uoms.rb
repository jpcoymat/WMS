class CreateUoms < ActiveRecord::Migration
  def self.up
    create_table :uoms do |t|
      t.string :code, :null => false, :limit => 5
      t.string :description, :limit => 50
      t.string :name, :limit => 25, :null => false
      t.string :measurement_type, :limit => 25
      t.boolean :continuous, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :uoms
  end
end
