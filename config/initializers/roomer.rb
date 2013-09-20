# Be sure to restart your server when you modify this file.
Roomer.setup do |config|

  # ==> Data Settings (Advanced)
  # IMPORTANT: Modifying these settings after you ran "rails generate roomer:setup" 
  # will require you to make manual changes in the database. Proceed with caution.

  # Configure the name of the shared schema, this is where all the shared 
  # tables are be present. The default is :global
  # config.shared_schema_name = :global

  # Configure the name of the table where the tenants are stored, this table must 
  # contain two required columns configured under:
  #     config.tenant_url_identifier_column
  #     config.tenant_schema_name_column
  # The default value is :tenants
  # config.tenants_table = :tenants

  # Configure the column name that strores the schema name in the tenants tables. 
  # The default value is :schema_name
  # config.tenant_schema_name_column = :schema_name

  # Configure the column name that strores the url identfier in the tenants tables.
  # A url idenfier is a unique value that identifies the tenant from the URL.
  # For e.g: if you use subdomains and the url is http://mytenant.myapp.com, 
  # the url identifier would "mytenant"
  # The default value is :url_identifier
  # config.tenant_url_identifier_column = :url_identifier

  # Configure the schema seperator. This is used when generating the table name. 
  # The default is set to ".". for e.g., tenant's table by default will be global.tenants
  # config.schema_seperator = "."

  # Use Tentant migrations directory?
  # Default is set to false
  config.use_tenanted_migrations_directory = true

  # Directory where shared migrations are stored. Please make
  # sure your migrations are present in this directory.
  config.shared_migrations_directory = File.join(Rails.root,"db","migrate", "global")

  # Directory where tenanted migrations are stored. Please make
  # sure your migrations are present in this directory.
  config.tenanted_migrations_directory = File.join(Rails.root,"db","migrate", "tenanted")

  # Directory where schema files will be stored.
  # config.schemas_directory = File.join(Rails.root, "db", "schemas")

  # Filename to use for tenanted schema
  # config.tenanted_schema_filename = "tenanted_schema.rb"

  # Filename to use for shared schema
  # config.shared_schema_filename = "shared_schema.rb"

  # Set to true for automatic inclusion
  # of Roomer::Middleware in the app's middleware
  # stack
  # config.install_middleware = true

  # Set to true for automatic inclusion
  # of Roomer::Extensions::Controller in
  # Application::Controller
  # config.install_controller_extensions = false

  # Safe to run on Heroku
  # Roomer.heroku_safe = true
end
