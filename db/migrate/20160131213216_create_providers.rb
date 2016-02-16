class CreateProviders < ActiveRecord::Migration
  def change
    create_table :providers do |t|
      t.integer :company_id, :limit => 3
      t.string :name, :limit => 150
      t.string :email, :limit => 200
      t.string :phone, :limit => 40

      t.timestamps null: false
    end

    add_index :providers, :company_id
  end
end
