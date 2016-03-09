class CreateCompaniesServicesProviders < ActiveRecord::Migration
  def change
    create_table :companies_services_providers do |t|
      t.integer :provider_id, :limit => 3
      t.integer :companies_service_id, :limit => 3

      t.timestamps null: false
    end

    add_index :providers_services, :provider_id
    add_index :providers_services, :companies_service_id
  end
end
