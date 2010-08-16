class CreateAssignments < ActiveRecord::Migration
  def self.up
    create_table :assignments do |t|
      t.integer :assignment_type_id, :null => false
      t.integer :user_id
      t.date :start_timestamp
      t.date :finish_timestamp
      t.boolean :released_flag, :null => false, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :assignments
  end
end
