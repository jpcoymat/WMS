class Country < ActiveRecord::Base

  has_many :companies

  validates	:name, :code, :presence => true

end
