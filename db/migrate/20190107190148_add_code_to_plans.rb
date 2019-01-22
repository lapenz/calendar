class AddCodeToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :code, :string
  end
end
