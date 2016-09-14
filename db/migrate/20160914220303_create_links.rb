class CreateLinks < ActiveRecord::Migration
  def change
    create_table :links do |t|
      t.string :title
      t.string :target_category
      t.string :target_info
      t.string :description
      t.string :tags

      t.timestamps null: false
    end
  end
end
