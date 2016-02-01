class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :user_id, :limit => 3
      t.integer :plan_id, :limit => 3
      t.integer :setting_id, :limit => 3
      t.string :name, :limit => 150
      t.string :email, :limit => 150
      t.string :phone, :limit => 40
      t.string :street, :limit => 200
      t.string :city, :limit => 200
      t.string :slogan, :limit => 100
      t.string :logo, :limit => 2083
      t.string :website, :limit => 2083
      t.string :minipage_url, :limit => 2083

      t.timestamps null: false
    end
    add_index :companies, :plan_id
    add_index :companies, :user_id
    add_index :companies, :setting_id
  end
end
