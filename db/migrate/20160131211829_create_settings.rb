class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :key
      t.string :value

      t.timestamps null: false
    end

    # populate the table
    Setting.create :key => "schedule_interval", :value => "15" # 15min
    Setting.create :key => "min_antecedence", :value => "720" # 12h
    Setting.create :key => "max_antecedence", :value => "43200" # 30 dias
  end
end
