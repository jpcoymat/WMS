class CreateAssignmentTypes < ActiveRecord::Migration
  def self.up
    create_table :assignment_types do |t|
      t.string :code, :null => false, :limit => 5
      t.string :name, :null => false, :limit => 25

      t.timestamps
    end
  end

  def self.down
    drop_table :assignment_types
  end
end
