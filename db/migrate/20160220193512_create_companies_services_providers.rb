class CreateCompaniesServicesProviders < ActiveRecord::Migration
  def change
    create_table :companies_services_providers do |t|
      t.integer :provider_id, :limit => 3
      t.integer :companies_service_id, :limit => 3

      t.timestamps null: false
    end

    add_index :companies_services_providers, :provider_id
    add_index :companies_services_providers, :companies_service_id
  end
end
