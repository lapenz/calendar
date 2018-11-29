class CreateCompaniesServicesResources < ActiveRecord::Migration[4.2]
  def change
    create_table :companies_services_resources do |t|
      t.integer :resource_id, :limit => 3
      t.integer :companies_service_id, :limit => 3

      t.timestamps null: false
    end

    add_index :companies_services_resources, :resource_id
    add_index :companies_services_resources, :companies_service_id
  end
end
