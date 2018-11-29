class CreateCompaniesServices < ActiveRecord::Migration[4.2]
  def change
    create_table :companies_services do |t|
      t.integer :company_id, :limit => 3
      t.integer :service_id, :limit => 3
      t.integer :duration, :null => false
      t.string :description, :limit => 150
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps null: false
    end

    add_index :companies_services, :company_id
    add_index :companies_services, :service_id
  end
end
