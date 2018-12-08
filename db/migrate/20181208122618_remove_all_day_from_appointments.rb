class RemoveAllDayFromAppointments < ActiveRecord::Migration[5.2]
  def change
    remove_column :appointments, :all_day, :integer
  end
end
