class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :mobile
      t.string :password

      t.timestamps null: false
    end
    add_index :users, :email, unique: true
    add_index :users, :mobile, unique: true
  end
end
