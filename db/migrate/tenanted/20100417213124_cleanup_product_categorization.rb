class CleanupProductCategorization < ActiveRecord::Migration

  def self.up
    remove_column   :products,  :category_type
    remove_column   :products,  :category_id
    add_column      :products,  :product_category_id,       :integer
    add_column      :products,  :product_subcategory_id,    :integer
  end

  def self.down
    remove_column   :products,  :product_category_id
    remove_column   :products,  :product_subcategory_id
    add_column      :products,  :category_type,             :string
    add_column      :products,  :category_id,               :string
  end
end
