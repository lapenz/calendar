class CreateOpeningHours < ActiveRecord::Migration
  def change
    create_table :opening_hours do |t|
      t.integer :companie_id, :limit => 3
      t.integer :provider_id, :limit => 3
      t.integer :weekday, :limit => 1
      t.time :from
      t.time :to

      t.timestamps null: false
    end

    add_index :opening_hours, :companie_id
    add_index :opening_hours, :provider_id
  end
end
