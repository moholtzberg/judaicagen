class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.belongs_to :item
      t.string :image
      t.string :name
      t.string :description
      t.string :path
      t.string :url
      t.string :file_name
      t.string :extension
      t.boolean :is_default
    end
  end
end