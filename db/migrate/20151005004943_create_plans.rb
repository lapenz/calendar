class CreatePlans < ActiveRecord::Migration[4.2]
  def change
    create_table :plans do |t|
      t.string :name, :limit => 45

      t.timestamps null: false
    end
  end
end
