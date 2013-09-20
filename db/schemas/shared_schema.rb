# It's strongly recommended to check this file into your version control system.
    
Roomer::Schema.define(:version => 20130920042236) do

  create_table "tenants", :force => true do |t|
    t.string   "url_identifier"
    t.string   "schema_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  add_index "tenants", ["schema_name"], :name => "index_tenants_on_schema_name", :unique => true
  add_index "tenants", ["url_identifier"], :name => "index_tenants_on_url_identifier", :unique => true

  # Database Views
  # The following statements persist database views across tenants

end
