class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :client_name
      t.references :item, index: true
      t.string :email

      t.timestamps null: false
    end
  end
end
