class CreatePlans < ActiveRecord::Migration
  def change
    create_table :plans do |t|
      t.string :name, :limit => 45

      t.timestamps null: false
    end
  end
end
