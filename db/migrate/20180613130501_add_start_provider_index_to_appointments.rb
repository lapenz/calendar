class AddStartProviderIndexToAppointments < ActiveRecord::Migration
  def change
    add_index :appointments, [:provider_id, :start], unique: true
  end
end
