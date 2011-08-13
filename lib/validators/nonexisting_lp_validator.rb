class NonexistingLpValidator < ActiveModel::EachValidator
  
  def validate_each(record, attribute, value)
    containers = Container.where(:lp => value).all
    receipt_lines = ReceiptLine.where(:lp => value).where("receipt_id <> #{record.receipt_id}")
    unless containers.empty? and receipt_lines.empty?
      record.errors[attribute] << "LP already exists."
    end
  end
  
end
