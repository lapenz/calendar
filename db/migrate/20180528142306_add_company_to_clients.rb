class AddCompanyToClients < ActiveRecord::Migration
  def change
    add_column :clients, :company_id, :integer
  end
end
