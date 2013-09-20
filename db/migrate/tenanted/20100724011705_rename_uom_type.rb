class RenameUomType < ActiveRecord::Migration
  def self.up
	rename_column	:uoms, :measurement_type,	:type
  end

  def self.down
  end
end
