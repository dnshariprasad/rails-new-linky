class AddEmailToLinks < ActiveRecord::Migration
  def change
    add_column :links, :email, :integer
    add_index :links, :email
  end
end
