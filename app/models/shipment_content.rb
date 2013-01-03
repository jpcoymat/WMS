class ShipmentContent < ActiveRecord::Base

	validates :shipment_id, :content_type, :content_id, :presence: true

	belongs_to	:shipment
	belongs_to	:content, :polymorphic => true




end
