class CreateContainerTypes < ActiveRecord::Migration
  def self.up
    create_table :container_types do |t|
      t.decimal :length, :scale => 2, :precision => 8, :null => false
      t.decimal :width, :scale => 2, :precision => 8, :null => false
      t.decimal :height, :scale => 2, :precision => 8, :null => false
      t.decimal :maximum_weight, :scale => 2, :precision => 8, :null => false
      t.string :purpose, :limit => 10

      t.timestamps
    end
  end

  def self.down
    drop_table :container_types
  end
end
