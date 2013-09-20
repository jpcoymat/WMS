class CreateAssignmentDetails < ActiveRecord::Migration
  def self.up
    create_table :assignment_details do |t|
      t.integer     :assignment_id,   :null => false
      t.integer     :expected_product_id
      t.integer     :actual_product_id
      t.integer     :expected_quantity
      t.integer     :actual_quantity
      t.integer     :from_location_id
      t.integer     :to_location_id
      t.integer     :from_container_id
      t.integer     :to_container_id
      t.date        :start_time
      t.date        :finish_time
      t.timestamps
    end
  end

  def self.down
    drop_table :assignment_details
  end
end
