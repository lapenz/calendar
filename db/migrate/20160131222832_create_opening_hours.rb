class CreateOpeningHours < ActiveRecord::Migration[4.2]
  def change
    create_table :opening_hours do |t|
      t.integer :company_id, :limit => 3
      t.integer :resource_id, :limit => 3
      t.string :weekdays, :limit => 50
      t.time :from
      t.time :to

      t.timestamps null: false
    end

    add_index :opening_hours, :company_id
    add_index :opening_hours, :resource_id
  end
end
