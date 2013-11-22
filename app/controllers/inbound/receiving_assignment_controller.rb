class Inbound::ReceivingAssignmentController < ApplicationController

  def index
    
  end

  def create
    @receiving_assignment = ReceivingAssignment.new(params[:receiving_assignment])
    if receiving_assignment_valid?(@receiving_assignment)
      
    end
  end
  
  protected
  
    def receiving_assignment_valid?(receiving_assignment)
      
      dock_door_valid? && lp_valid?
    end
    
    def dock_door_valid?(dock_door_name, user_id)
      @dock_door = DockDoor.where(:name => dock_door_name, :warehouse_id => User.find(user_id).warehouse.id).first
      @dock_door
    end
    
    def lp_valid?(lp)
      lp_is_valid = true
      @receipt_lines = ReceiptLine.where(:lp => lp)
      unless @receipt_lines.empty?
        @receipt_lines.each do |receipt_line|
          if !(receipt_line.created?)
            lp_is_valid = false
            break
          end
        end
      else
        lp_is_valid = false
      end
      lp_is_valid
    end
    
    def same_lp?(receipt_lines)
      lp = receipt_lines.first.lp
      same_lp = true
      index = 1
      while same_lp and index < receipt_lines.count
        same_lp = (lp == receipt_lines[index].lp) 
        index += 1
      end
      same_lp
    end
    
    def single_dock_door?(receipt_lines)
    end

end
