class ProductCategoryMatchValidator < ActiveModel::EachValidator

  def validate_each(record,attribute,value)
    unless value.nil?
      record_product_category = record.product_category
      value_product_category = ProductSubcategory.find(value).product_category
      unless value_product_category == record_product_category
        record.errors[attribute] << "Product Category on record and Subcategory don't match"
      end
    end
  end

end