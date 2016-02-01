class CreateCompaniesServices < ActiveRecord::Migration
  def change
    create_table :companies_services do |t|
      t.integer :companie_id, :limit => 3
      t.integer :service_id, :limit => 3
      t.time :duration
      t.string :description, :limit => 150
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps null: false
    end

    add_index :companies_services, :companie_id
    add_index :companies_services, :service_id
  end
end
