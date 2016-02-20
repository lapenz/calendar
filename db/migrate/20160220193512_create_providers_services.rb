class CreateProvidersServices < ActiveRecord::Migration
  def change
    create_table :providers_services do |t|
      t.integer :provider_id, :limit => 3
      t.integer :company_service_id, :limit => 3

      t.timestamps null: false
    end

    add_index :providers_services, :provider_id
    add_index :providers_services, :company_service_id
  end
end
