class CreateSystemParameters < ActiveRecord::Migration
  def self.up
    create_table :system_parameters do |t|
      t.string :code, :limit => 3, :null => false
      t.string :name, :limit => 50, :null => false
      t.string :description, :limit => 100
      t.string :value, :limit => 10, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :system_parameters
  end
end
