class SupplierMatchValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.nil?
      receipt_supplier = record.supplier
      purchase_order_line = PurchaseOrderLine.find(value)
      po_line_supplier = purchase_order_line.purchase_order.supplier
      if receipt_supplier
        if po_line_supplier 
          unless receipt_supplier == po_line_supplier
            record.errors[attribute] << "Supplier on PO does not match supplier on Receipt"
          end
        end
        
      end
    end
  end
  

end

