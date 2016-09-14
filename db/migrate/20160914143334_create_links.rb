class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :url
      t.string :description
      t.string :tags

      t.timestamps null: false
    end
  end
end
