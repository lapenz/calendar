class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.integer :user_id, :limit => 3
      t.integer :plan_id, :limit => 3
      t.string :name, :limit => 150
      t.string :email, :limit => 150
      t.string :phone, :limit => 40
      t.string :street, :limit => 200
      t.string :city, :limit => 200
      t.string :slogan, :limit => 100
      t.string :logo, :limit => 2083
      t.string :website, :limit => 2083
      t.string :minipage_url, :limit => 2083
      t.integer :schedule_interval, :limit => 2, :default => '900' # 15 min
      t.integer :min_antecedence, :limit => 3, :default => '3600' # 1 hora
      t.integer :max_antecedence, :default => '2592000' # 1 mes

      t.timestamps null: false
    end
    add_index :companies, :plan_id
    add_index :companies, :user_id
  end
end
