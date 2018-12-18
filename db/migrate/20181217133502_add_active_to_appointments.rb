class AddActiveToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :active, :boolean, default: true
  end
end
