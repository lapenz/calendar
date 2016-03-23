class CreateOpeningHours < ActiveRecord::Migration
  def change
    create_table :opening_hours do |t|
      t.integer :company_id, :limit => 3
      t.integer :provider_id, :limit => 3
      t.string :weekdays, :limit => 13
      t.time :from
      t.time :to

      t.timestamps null: false
    end

    add_index :opening_hours, :company_id
    add_index :opening_hours, :provider_id
  end
end
