class AssignmentType < ActiveRecord::Base

  roomer :tenanted

  belongs_to :company

end
