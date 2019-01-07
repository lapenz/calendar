class RemoveAppointmentsResourceStartIndex < ActiveRecord::Migration[5.2]
  def change
    remove_index :appointments, name: "index_appointments_on_resource_id_and_start"
  end
end
