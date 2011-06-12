class LocationController < ApplicationController

  before_filter :authorize
  
  def locations
    @warehouse = User.find(session[:user_id]).warehouse
    if request.post?
      params[:location].delete_if {|k,v| v.blank?   }
      params[:location][:warehouse_id] = @warehouse.id
      @locations = Location.all(:conditions => params[:location], :order => 'name')
    end
  end
  
  def view_location
    @location = Location.find(params[:location])
  end
  
  def edit_location
    @location = Location.find(params[:location])
    @warehouse = @location.warehouse
  end
  
  def update_location
    @location = Location.find(params[:location][:id])
    if @location.update_attributes(params[:location])
      @location.save
      redirect_to :controller => 'admin', :action => 'view_location', :location => @location
    else
      flash[:notice] = "Error updating Location"
      redirect_to :controller => 'admin', :action => 'edit_location', :location => @location
    end
  end
  
  def add_locations
    @warehouse = User.find(session[:user_id]).warehouse
    @location_types = @warehouse.location_types
    if request.post?
      @location_type = LocationType.find(params[:location_type][:id])
    end
  end
  
  def create_locations
    @location_type = LocationType.find(params[:locations][:location_type_id])
    location_range = params[:locations].clone.delete_if {|k,v| !(k.include?("from_") or k.include?("to_"))}
    if @location_type.location_range_valid?(location_range)
      location_attributes = params[:locations].clone.delete_if { |k,v| (k.include?("from_") or k.include?("to_"))}
      code_to_execute = create_loop_string(location_range, @location_type.active_components_array, location_attributes)
      eval code_to_execute
      redirect_to :controller => 'admin', :action => 'locations'
    else
      flash[:notice] = "Location Range is not valid"
      redirect_to :controller => 'admin', :action => 'add_locations'
    end
  end

  def create_loop_string(location_range, location_components, location_attributes)
    loop_string = ""
    loc_attr = "{"
    location_attributes.each_pair do |k,v|
      loc_attr += %{ "#{k.to_s}" => "#{v.to_s}",}
    end
    loc_attr.chop!
    loc_attr += "}"
    location_components.each do |location_component|
      start = "from_" + location_component
      finish = "to_" + location_component
      loop_string += %{ for #{location_component} in ('#{location_range[start]}' .. '#{location_range[finish]}' ) 
                      }
    end
    loop_string += %{ location = Location.new(#{loc_attr}) 
                  }
    location_components.each do |location_component|
      loop_string += %{ location.#{location_component} = #{location_component} 
                    }
    end
    loop_string += %{ location.save
                      }
    location_components.count.times do 
      loop_string += %{ end 
                      }
    end
    loop_string
  
  
  end
  

end
