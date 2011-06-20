class ProductMatchValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.nil? 
      purchase_order_line = PurchaseOrderLine.find(value)
      unless purchase_order_line.product_id == record.attributes["product_id"]
        record.errors[attribute] << "Product on PO Line does not match Product on record"
      end
    end
  end

end