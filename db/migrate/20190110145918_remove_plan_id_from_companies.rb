class RemovePlanIdFromCompanies < ActiveRecord::Migration[5.2]
  def change
    remove_column :companies, :plan_id, :integer
  end
end
