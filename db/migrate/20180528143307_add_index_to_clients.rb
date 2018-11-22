class AddIndexToClients < ActiveRecord::Migration
  def change
     add_index :clients, [:email, :company_id], unique: true
  end
end
