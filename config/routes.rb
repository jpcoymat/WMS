Wms::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
  
  namespace :admin do
    resources :allocation_strategies do 
      resources :allocation_strategy_lines
    end
    resources :allocation_strategy_rules
    resources :allocation_zones
    resources :companies do
      member do
        get 'uom_setup'
      end
    end
    resources :customer_types
    resources :location_types
    resources :locations  do
      collection do
        get 'lookup'
        post 'lookup'
        get 'add'
        post 'add'
      end
    end       
    resources :order_types
    resources :product_categories do
      resources :product_subcategories
    end
    resources :product_location_assignments do
      collection do
        get 'replenishment_locations'
        post 'replenishment_locations'
      end
    end
    resources :product_statuses
    resources :products do
      resources :product_packages
      resources :product_warehouse_setups
      collection do
        get 'lookup'
        post 'lookup'
      end
    end
    resources :purchase_order_types
    resources :receipt_types
    resources :storage_strategies do
      resources :storage_strategy_lines
    end
    resources :storage_strategy_rules
    resources :storage_zones
    resources :suppliers
    resources :system_parameters do
      collection do
        get 'lookup'
        post 'lookup'
      end
    end
    resources :uoms
    resources :quantity_uoms,   controller: 'uoms', type: 'QuantityUom'
    resources :dimension_uoms,  controller: 'uoms', type: 'DimensionUom'
    resources :volume_uoms,     controller: 'uoms', type: 'VolumeUom'
    resources :weight_uoms,     controller: 'uoms', type: 'WeightUom'
    resources :users
    resources :warehouses do
      resources :dock_doors
    end
  end

  namespace :inbound do
    resources :purchase_orders do
      resources :purchase_order_lines 
      collection do
        get 'lookup'
        post 'lookup'
      end
    end
    resources :receipts do
      resources :receipt_lines
      collection do
        get 'lookup'
        post 'lookup'
      end
    end            
  end
  
  namespace :outbound do
    resources :orders do
      resources :order_lines
      collection do
        get 'lookup'
        post 'lookup'
      end
    end
    resources :shipments
  end
  
  controller :javascripts do
    get 'javascripts/dynamic_product_subcategories'
    get 'javascripts/dynamic_po_lines'
    get 'javascripts/set_product'
  end

  controller :login do
    get 'login' => :login
    post 'validate_user'=> :validate_user
    get 'logout' => :logout
  end
  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => 'main#index'

  # See how all your routes lay out with "rake routes"

end
