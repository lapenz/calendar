class AddVisibleToCompaniesServices < ActiveRecord::Migration[5.2]
  def change
    add_column :companies_services, :visible, :boolean
  end
end
