class Tenant < ActiveRecord::Base
  # load tenanted schema.rb file to provision new tenant
  after_create :load_schema

  # tell roomer if this is a shared model
  roomer :shared

  protected
  def load_schema
    Roomer::Schema.load(schema_name)
  end
end
