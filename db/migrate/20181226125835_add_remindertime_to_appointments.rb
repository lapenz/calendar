class AddRemindertimeToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :remindertime, :integer
  end
end
