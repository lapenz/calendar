class CreateAppointments < ActiveRecord::Migration[4.2]
  def change
    create_table :appointments do |t|
      t.integer :resource_id, :limit => 3
      t.integer :companies_service_id, :limit => 3
      t.integer :client_id, :limit => 3
      t.timestamp :start
      t.timestamp :end
      t.integer :all_day, :limit => 1
      t.string :obs, :limit => 200
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps null: false
    end

    add_index :appointments, :resource_id
    add_index :appointments, :companies_service_id
    add_index :appointments, :client_id
  end
end
