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
    uoms = Uom.create([{:code => "EACH",  :description => "Each",         :name => "Each",      :type => "Quantity",  :discrete => true,  :company_id => self.id},
                       {:code => "CASE",  :description => "Case",         :name => "Case",      :type => "Quantity",  :discrete => true,  :company_id => self.id},
                       {:code => "PALT",  :description => "Pallet",       :name => "Pallet",    :type => "Quantity",  :discrete => true,  :company_id => self.id},
                       {:code => "M",     :description => "Meter",        :name => "Meter",     :type => "Dimension", :discrete => true,  :company_id => self.id},
                       {:code => "FT",    :description => "Foot",         :name => "Foot",      :type => "Dimension", :discrete => true,  :company_id => self.id},
                       {:code => "IN",    :description => "Inch",         :name => "Inch",      :type => "Dimension", :discrete => true,  :company_id => self.id},
                       {:code => "LP",    :description => "Pound",        :name => "Pound",     :type => "Weight",    :discrete => true,  :company_id => self.id},
                       {:code => "KG",    :description => "Kilogram",     :name => "Kilogram",  :type => "Weight",    :discrete => true,  :company_id => self.id},
                       {:code => "M3",    :description => "Meter Cubed",  :name => "Cu M",      :type => "Volume",    :discrete => true,  :company_id => self.id},
                       {:code => "F3",    :description => "Foot Cubed",   :name => "Cu Ft",     :type => "Volume",    :discrete => true,  :company_id => self.id},
                       {:code => "I3",    :description => "Inch Cubed",   :name => "Cu In",     :type => "Volume",    :discrete => true,  :company_id => self.id}])
  end

  def create_assignment_types
    assignment_types = AssignmentType.create([	
            {:code => "RC01",	:name => "Receiving Shipment",		    :company_id => self.id},
						{:code => "RC02",	:name => "Receive Against PO",		    :company_id => self.id},
						{:code => "ST01",	:name => "Directed Storage",		      :company_id => self.id},
						{:code => "ST02",	:name => "Manual Storage",		        :company_id => self.id},
						{:code => "ST03",	:name => "Directed Outbound Staging", :company_id => self.id},
						{:code => "ST04", :name => "Manual Outbound Staging",	  :company_id => self.id},
						{:code => "MV01",	:name => "Drop-off Move",		          :company_id => self.id},
						{:code => "MV02", :name => "Manual Move",			          :company_id => self.id},
						{:code => "RP01",	:name => "Replenishment",		          :company_id => self.id},
						{:code => "PP01",	:name => "Pick from Fixed Pick Loc",	:company_id => self.id},
						{:code => "PP02",	:name => "Full Container Pick",		    :company_id => self.id},
						{:code => "PP03", :name => "Logical Case Pick",		      :company_id => self.id},
						{:code => "PP04",	:name => "Logical Pallet Pick",		    :company_id => self.id},
						{:code => "PP05",	:name => "Topmost Container Pick",	  :company_id => self.id},
						{:code => "LD01",	:name => "Directed Loading",		      :company_id => self.id},
						{:code => "LD02",	:name => "Manual Loading",		        :company_id => self.id}	])
  end

  def create_product_statuses
    product_statuses = ProductStatus.create([
      {:code => "AV", :description => "Available",      :allocatable => true,   :company_id => self.id  },
      {:code => "DM", :description => "Damaged",        :allocatable => false,  :company_id => self.id  },
      {:code => "HD", :description => "On-Holde",       :allocatable => false,  :company_id => self.id  },
      {:code => "QA", :description => "Quality Audit",  :allocatable => false,  :company_id => self.id  }])
  end

end
