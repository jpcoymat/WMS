class ChangeProductIdTypeOnProdPackage < ActiveRecord::Migration
  def up
   #change_column :product_packages, :product_id, :integer
   ActiveRecord::Base.connection.execute(%{
     ALTER TABLE product_packages
     ALTER COLUMN product_id TYPE integer
     USING (product_id::integer)
   })
  end

  def down
  end
end
