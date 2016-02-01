class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :companie_id, :limit => 3
      t.string :name, :limit => 150
      t.string :email, :limit => 200
      t.string :phone, :limit => 40

      t.timestamps null: false
    end
  end
end
