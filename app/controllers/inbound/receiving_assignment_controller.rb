class Inbound::ReceivingAssignmentController < ApplicationController

  def index
    
  end

  def create
    @receipt_lines = ReceiptLine.where(:lp => params[:receiving_assignment][:assignment_detial][:lp]).all
    if @receipt_lines
      @dock_door = DockDoor.where(:name => 'name')
      if @receipt_lines.first.receipt.state == "created"
        @receiving_assignment = ReceivingAssignment.new(:user_id => session[:user_id], :start_timestamp => Time.now, :priority => 0)
        @receipt_lines.each do |receipt_line|
          @receiving_assignment.assignment_details.build( :expected_product_id => receipt_line.product_id, 
                                                          :actual_product_id => receipt_line.product_id,
                                                          :expected_quantity => receipt_line.quantity,
                                                          :actual_quantity => receipt_line.quantity,
                                                          :from_location => @dock_door,
                                                          :to_location => @dock_door)
        end
        
      elsif @receit_lines.first.receipt.state == "in_receiving"
        
      end
    end
  end
  
  protected
  
    def validate_receiving_assignment(receiving_assignment)
      
    end
    
    def validate_dock_door(dock_door_name, user_id
      @dock_door = DockDoor.where(:name => dock_door_name, :warehouse_id => User.find(user_id).warehouse.id)
      @dock_door
    end
    
    

end
