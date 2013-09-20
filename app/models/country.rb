class Country < ActiveRecord::Base

  has_many :companies

  validates	:name, :iso_code, presence: true

  roomer :shared
end
