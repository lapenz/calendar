class CreateAppointments < ActiveRecord::Migration
  def change
    create_table :appointments do |t|
      t.integer :companie_id, :limit => 3
      t.integer :provider_service_id, :limit => 3
      t.integer :client_id, :limit => 3
      t.string :title, :limit => 45
      t.timestamp :start
      t.timestamp :end
      t.integer :all_day, :limit => 1
      t.string :obs, :limit => 200
      t.decimal :price, :precision => 10, :scale => 2

      t.timestamps null: false
    end

    add_index :appointments, :companie_id
    add_index :appointments, :provider_service_id
    add_index :appointments, :client_id
  end
end
