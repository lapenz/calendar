class AddStartResourceIndexToAppointments < ActiveRecord::Migration[4.2]
  def change
    add_index :appointments, [:resource_id, :start], unique: true
  end
end
