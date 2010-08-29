# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#   
#   cities = City.create([{ :name => 'Chicago' }, { :name => 'Copenhagen' }])
#   Major.create(:name => 'Daley', :city => cities.first)
countries = Country.create([	{:name => "Colombia", :code => "COL", :iso_code => "COL", :telephone_country_code => 57, :language => "Spanish"},
				{:name => "United States", :code => "USA", :iso_code => "USA", :telephone_country_code => 1, :language => "English"}])

