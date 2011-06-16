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
        post 'new'
      end
    end       
    resources :order_types
    resources :product_categories do
      resources :product_subcategories
    end
    resources :product_location_assignments
    resources :product_packages
    resources :product_statuses
    resources :product_warehouse_setups
    resources :products
    resources :purchase_order_types
    resources :receipt_types
    resources :storage_strategies do
      resources :storage_strategy_lines
    end
    resources :storage_strategy_rules
    resources :storage_zones
    resources :suppliers
    resources :system_parameters
    resources :uoms
    resources :users
    resources :warehouses do
      resources :dock_doors
    end
  end


  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  root :to => "main#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.

  match ':controller(/:action(/:id(.:format)))' 
  match ':controller/:action.:format' 
end
