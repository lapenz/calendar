class AddAlldayToAppointments < ActiveRecord::Migration[5.2]
  def change
    add_column :appointments, :allday, :boolean
  end
end
