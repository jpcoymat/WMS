class Admin::LocationsController < ApplicationController

  
  def lookup
    @warehouse = current_user.warehouse
    if request.post?
      params[:location].delete_if {|k,v| v.blank?   }
      params[:location][:warehouse_id] = @warehouse.id
      @locations = Location.all(:conditions => params[:location], :order => 'name')
    end
  end
  
  def show
    @location = Location.find(params[:id])
  end
  
  def edit
    @location = Location.find(params[:id])
    @warehouse = @location.warehouse
  end
  
  def update
    @location = Location.find(params[:id])
    if @location.update_attributes(params[:location])
      redirect_to admin_location_path(@location)
    else
      flash[:notice] = "Error updating Location"
      @warehouse = @location.warehouse
      render :action => 'edit'
    end
  end
  
  def add
    @warehouse = current_user.warehouse
    @location_types = @warehouse.location_types
    if request.post?
      @location_type = LocationType.find(params[:location_type][:id])
      @locations = Location.new
    end
  end
  
  def create
    @location_type = LocationType.find(params[:location_data][:location_type_id])
    location_range = params[:location_data].clone.delete_if {|k,v| !(k.include?("from_") or k.include?("to_"))}
    if @location_type.location_range_valid?(location_range)
      location_attributes = params[:location_data].clone.delete_if { |k,v| (k.include?("from_") or k.include?("to_"))}
      code_to_execute = create_loop_string(location_range, @location_type.active_components_array, location_attributes)
      eval code_to_execute
      redirect_to lookup_admin_locations_path
    else
      flash[:notice] = "Location Range is not valid"
      @warehouse = current_user.warehouse
      @location_types = @warehouse.location_types
      render :action => 'add'
    end
  end

  private

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
