class AddIndexToMinipageUrl < ActiveRecord::Migration[5.2]
  def change
    add_index :companies, :minipage_url, :unique => true
  end
end
