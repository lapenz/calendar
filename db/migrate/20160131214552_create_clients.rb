class CreateClients < ActiveRecord::Migration[4.2]
  def change
    create_table :clients do |t|
      t.string :name, :limit => 150
      t.string :email, :limit => 200
      t.string :phone, :limit => 40

      t.timestamps null: false
    end

  end
end
