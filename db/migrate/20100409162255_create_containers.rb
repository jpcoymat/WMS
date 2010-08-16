class CreateContainers < ActiveRecord::Migration
  def self.up
    create_table :containers do |t|
      t.string :lp, :null => false, :limit => 50
      t.reference :container_location, :polymorphic => true, :null => false
      t.integer :container_type_id
      t.decimal :length, :precision => 8, :scale => 2
      t.decimal :width, :precision => 8, :scale => 2
      t.decimal :height, :precision => 8, :scale => 2
      t.decimal :max_weight, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :containers
  end
end
