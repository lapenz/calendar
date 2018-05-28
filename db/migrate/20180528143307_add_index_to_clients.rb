class AddIndexToClients < ActiveRecord::Migration
  def change
    remove_index :clients, :email
    add_index :clients, [:email, :company_id], unique: true
  end
end
