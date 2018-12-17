class AddRepeatIdToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :repeat_id, :integer
  end
end
