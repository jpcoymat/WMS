class Wave < ActiveRecord::Base

  include AASM
  
  aasm_column :state
  aasm_initial_state :created
  aasm_state  :created
  aasm_state  :allocating
  aasm_state  :containerizing
  aasm_state  :completed
  
  belongs_to  :warehouse
  has_many    :order_lines

  validates :wave_number, :state, :warehouse_id, presence: true 
  validates_uniqueness_of :wave_number, scope: :warehouse_id
  
    
  
end
