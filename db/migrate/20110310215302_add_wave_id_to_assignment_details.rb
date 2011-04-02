class AddWaveIdToAssignmentDetails < ActiveRecord::Migration
  def self.up
	add_column :assignment_details, :wave_id, :integer
  end

  def self.down
  end
end
