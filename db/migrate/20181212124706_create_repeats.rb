class CreateRepeats < ActiveRecord::Migration[5.2]
  def change
    create_table :repeats do |t|
      t.string :typerepeat, :limit => 45
      t.integer :interval, :limit => 2
      t.string :weekdays, :limit => 50
      t.date :end

      t.timestamps
    end
  end
end
