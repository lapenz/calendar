class AddCompanyToClients < ActiveRecord::Migration[4.2]
  def change
    add_column :clients, :company_id, :integer
  end
end
