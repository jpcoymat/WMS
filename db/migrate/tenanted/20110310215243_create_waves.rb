class CreateWaves < ActiveRecord::Migration
  def self.up
    create_table :waves do |t|
      t.string :wave_number, :limit => 25, :null => false 
      t.datetime :started_running_at
      t.datetime :stopped_running_at
      t.string :state, :limit => 25, :null => false
      t.integer :user_id, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :waves
  end
end
