class AddCompanyAssignmentType < ActiveRecord::Migration

  def self.up
	add_column :assignment_types, :company_id, :integer, :null => false
  end

  def self.down
	add_column :assignment_types, :company_id
  end
end
