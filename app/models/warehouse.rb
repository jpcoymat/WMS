class Warehouse < ActiveRecord::Base

  belongs_to  :company
  belongs_to  :country
  has_many    :locations
  has_many    :allocation_zones
  has_many    :storage_zones
  has_many    :dock_doors
  has_many    :system_parameters
  has_many    :users
  has_many    :receipts
  has_many    :storage_strategies
  has_many    :storage_strategy_rules
  has_many    :allocation_strategies
  has_many    :allocation_strategy_rules
  has_many    :location_types
  has_many    :product_location_assignments
  has_many    :product_warehouse_setups
  has_many    :products, :through => :product_warehouse_setups
  has_many    :shipments


  validates	:name, :uniqueness => true
  validates	:code, :uniqueness => true 
  validates 	:name, :code, :address_1, :city, :country_id, :company_id, :presence => true

  def add_system_parameters
    SystemParameter.create([{ 
                              :code => "100", 
                              :name => "Deferred Storage", 
                              :description => "Determine Storage Location only when requested", 
                              :value => true, 
                              :warehouse_id => self.id
                            },
                            { 
                              :code => "101",
                              :name => "Allocate Receipts",
                              :description => "Allocate non-stored containers against wave shortages",
                              :value => true,
                              :warehouse_id => self.id
                            },
                            {
                              :code => "102",
                              :name => "Cross Dock",
                              :description => "Allocate new receipts against wave shortages",
                              :value => true,
                              :warehouse_id => self.id
                            },
                            {
                              :code => "103",
                              :name => "Over-receipt",
                              :description => "Allow over-receipt of Purchase Order",
                              :value => true,
                              :warehouse_id => self.id
                            }])
  end
  
  def deleteable?
    self.locations.empty? and self.allocation_zones.empty? and self.storage_zones.empty? and self.dock_doors.empty? and self.users.empty?
  end
  
  def receivable_receipts
    @receivable_receipts = Receipt.where(:warehouse_id => self.id, :state => "created").all
  end
  
  def closeable_receipts
    @closeable_receipts = Receipt.where(:warehouse_id => self.id, :state => "in_receiving").all
  end
  

end
