class Company < ActiveRecord::Base

  belongs_to :country
  has_many  :warehouses
  has_many  :products
  has_many  :customers
  has_many  :customer_types 
  has_many  :purchase_order_types
  has_many  :purchase_orders
  has_many  :receipt_types
  has_many  :orders
  has_many  :order_types
  has_many  :product_statuses
  has_many  :product_categories
  has_many  :product_subcategories
  has_many  :suppliers
  has_many  :uoms
  has_many  :assignment_types
  
  has_many :volume_uoms
  has_many :quantity_uoms
  has_many :weight_uoms
  has_many :dimension_uoms  

  validates	:name, :uniqueness => true
  validates	:name, :address_1, :city, :country_id, :presence => true

  def default_quantity_uom
    @default_quantity_uom = QuantityUom.find(self.default_quantity_uom_id)
  end
  
  def default_weight_uom
    @default_weight_uom = WeightUom.find(self.default_weight_uom_id)
  end

  def default_length_uom
    @default_length_uom = DimensionUom.find(self.default_length_uom_id)
  end

  def create_uoms
    quantity_uoms = QuantityUom.create([{:code => "EACH",  :description => "Each", 	:name => "Each", 	:discrete => true, :company_id => self.id},
                       			{:code => "CASE",  :description => "Case",      :name => "Case",      	:discrete => true,  :company_id => self.id},
                       			{:code => "PALT",  :description => "Pallet",    :name => "Pallet",    	:discrete => true,  :company_id => self.id},
		       			{:code => "UNIT",  :description => "Unit",	:name => "Unit",	:discrete => true,  :company_id => self.id}])	

    dimension_uoms = DimensionUom.create([{:code => "M", :description => "Meter", 	:name => "Meter",	:discrete => true,  :company_id => self.id},
                       			{:code => "FT",    :description => "Foot",	:name => "Foot",      	:discrete => true,  :company_id => self.id},
                      	 		{:code => "IN",    :description => "Inch",	:name => "Inch",      	:discrete => true,  :company_id => self.id}])

    weight_uoms = WeightUom.create([{:code => "LP", :description => "Pound", 	:name => "Pound",	:discrete => true,  :company_id => self.id},
                       		{:code => "KG",    :description => "Kilogram",	:name => "Kilogram",  	:discrete => true,  :company_id => self.id}])

     volume_uoms = VolumeUom.create([{:code => "M3",    :description => "Meter Cubed",  :name => "Cu M", :discrete => true,  :company_id => self.id},
                       		{:code => "F3",    :description => "Foot Cubed",   :name => "Cu Ft",    :discrete => true,  :company_id => self.id},
                       		{:code => "I3",    :description => "Inch Cubed",   :name => "Cu In",    :discrete => true,  :company_id => self.id}])
  end


  def create_product_statuses
    product_statuses = ProductStatus.create([
      {:code => "AV", :description => "Available",      :allocatable => true,   :company_id => self.id  },
      {:code => "DM", :description => "Damaged",        :allocatable => false,  :company_id => self.id  },
      {:code => "HD", :description => "On-Hold",        :allocatable => false,  :company_id => self.id  },
      {:code => "QA", :description => "Quality Audit",  :allocatable => false,  :company_id => self.id  }])
  end

end
