class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :owner_id
      t.string :title
      t.text :description
      t.string :family_name
      t.string :town_name
      t.timestamps null: false
    end
  end
end