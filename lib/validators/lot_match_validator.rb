class LotMatchValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    unless value.nil?
      order_line_product = record.product
      lot = Lot.find(value)
      if lot
        unless order_line_product.lots.include?(lot)
          record.errors[attribute] << "Lot does not exist for product."
        end
      end
    end
  end
  
end
