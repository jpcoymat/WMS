class RenameContinuous < ActiveRecord::Migration

  def self.up
    rename_column :uoms, :continuous, :discrete
  end

  def self.down
  end
end
