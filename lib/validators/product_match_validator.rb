class ProductMatchValidator < ActiveModel::EachValidator

  def validate_each(record, attribute, value)
    unless value.nil? 
      remote_object = attribute.to_s.gsub("_id","").camelize.constantize.find(value)
      unless remote_object.product == record.product
        record.erros[attribute] << "#{remote_object.humanize}'s Product does not match record product"
      end
    end
  end

end