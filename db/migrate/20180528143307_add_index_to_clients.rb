class AddIndexToClients < ActiveRecord::Migration[4.2]
  def change
     add_index :clients, [:email, :company_id], unique: true
  end
end
