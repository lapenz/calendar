class AddStartResourceIndexToAppointments < ActiveRecord::Migration
  def change
    add_index :appointments, [:resource_id, :start], unique: true
  end
end
