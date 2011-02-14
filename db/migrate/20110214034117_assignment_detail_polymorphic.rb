class AssignmentDetailPolymorphic < ActiveRecord::Migration

  def self.up
    remove_column :assignment_details,  :from_location_id
    remove_column :assignment_details,  :to_location_id
    add_column    :assignment_details,  :start_location_type, :string,  :limit => 25
    add_column    :assignment_details,  :start_location_id,   :integer
    add_column    :assignment_details,  :end_location_type,   :string,  :limit => 25
    add_column    :assignment_details,  :end_location_id,     :integer
  end

  def self.down
  end
end
