class LotMatchValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    unless value.nil?
      product = record.product
      lot = Lot.find(value)
      unless product.lots.include?(lot)
        record.errors[attribute] << "Lot does not exist for product."
      end
    end
  end
  
end
