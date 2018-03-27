class AddStripeCardTokenToPayment < ActiveRecord::Migration
  def change
    add_column :payments, :card_token, :string
  end
end
