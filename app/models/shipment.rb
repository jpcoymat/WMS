class Shipment < ActiveRecord::Base


  include AASM

  aasm_column :state
  aasm_initial_state :created
  aasm_state  :created
  aasm_state :arrived
  aasm_state :departed
  aasm_state :canceled


  aasm_event :arrive do
    transitions :to => :arrived, :from => [:created]
  end

  aasm_event :depart do
    transitions :to => :departed, :from => [:arrived]
  end

  aasm_event :cancel do
    transitions :to => :canceled, :from => [:created]
  end





end
